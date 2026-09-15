"""
Lab 11: Construção de Dashboard Analítico Interativo
Gera visualização executiva em HTML autônomo (Plotly) com 4 seções:
KPIs de topo, gráfico de risco por segmento e tabela de detalhe.
"""
import os
import pandas as pd
import plotly.graph_objects as go
from plotly.subplots import make_subplots

def generate_dashboard():
    csv_path = 'scripts/fraud_risk_export.csv'
    if not os.path.exists(csv_path):
        csv_path = 'fraud_risk_export.csv'

    fraud_risk = pd.read_csv(csv_path)

    fig = make_subplots(
        rows=2, cols=2,
        specs=[
            [{'type': 'indicator'}, {'type': 'indicator'}],
            [{'type': 'bar'}, {'type': 'table'}]
        ],
        subplot_titles=('', '', 'Taxa de Fraude por Segmento (%)', 'Detalhamento Analítico dos Segmentos')
    )

    total_tx = int(fraud_risk['total_transacoes'].sum())
    fig.add_trace(go.Indicator(
        mode='number',
        value=total_tx,
        title={'text': 'Total de Transações Processadas'}
    ), row=1, col=1)

    total_fraudes = fraud_risk['qtd_fraudes'].sum()
    taxa_geral = (100.0 * total_fraudes) / total_tx
    fig.add_trace(go.Indicator(
        mode='number',
        value=round(taxa_geral, 2),
        number={'suffix': '%'},
        title={'text': 'Taxa de Fraude Geral'}
    ), row=1, col=2)

    color_map = {'High-Risk': '#e5484d', 'Standard': '#f5a623', 'Premium': '#2ecc71'}
    bar_colors = [color_map.get(s, '#3498db') for s in fraud_risk['segment']]

    fig.add_trace(go.Bar(
        x=fraud_risk['segment'],
        y=fraud_risk['taxa_fraude_pct'],
        marker_color=bar_colors,
        hovertemplate='Segmento: %{x}<br>Taxa de Fraude: %{y:.2f}%<extra></extra>',
        name='Taxa de Fraude'
    ), row=2, col=1)

    fig.add_trace(go.Table(
        header=dict(
            values=[f'<b>{c}</b>' for c in fraud_risk.columns],
            fill_color='#1f2937',
            font=dict(color='white', size=12),
            align='center'
        ),
        cells=dict(
            values=[fraud_risk[c] for c in fraud_risk.columns],
            fill_color='#f9fafb',
            font=dict(color='#111827', size=11),
            align='center',
            height=28
        )
    ), row=2, col=2)

    fig.update_layout(
        height=700,
        title_text='<b>Painel Executivo de Risco e Prevenção a Fraudes — TechPay</b>',
        template='plotly_white',
        showlegend=False
    )

    os.makedirs('relatorios', exist_ok=True)
    fig.write_html('relatorios/dashboard_fraude.html')
    print("Dashboard gerado com sucesso em relatorios/dashboard_fraude.html")

if __name__ == '__main__':
    generate_dashboard()
