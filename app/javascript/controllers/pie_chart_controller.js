import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js'
Chart.register(...registerables);

export default class extends Controller {
  static targets = ["switchButton", "canvas"]

  connect() {
    this.statusData = JSON.parse(this.canvasTarget.dataset.statusData)
    this.categoryData = JSON.parse(this.canvasTarget.dataset.categoryData)
    this.renderChart(this.statusData, 'Items by Status')
  }

  showStatus(event) {
    this.updateChart(this.statusData, 'Items by Status')
    this.setActiveButton(event.currentTarget)
  }

  showCategory(event) {
    this.updateChart(this.categoryData, 'Items by Category')
    this.setActiveButton(event.currentTarget)
  }

  renderChart(data, label) {
    const labels = Object.keys(data)
    const values = Object.values(data)
    const backgroundColors = this.generateColors(labels.length)

    this.chart = new Chart(this.canvasTarget, {
      type: 'pie',
      data: {
        labels: labels,
        datasets: [{
          label: label,
          data: values,
          backgroundColor: backgroundColors,
          hoverOffset: 4
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
      }
    });
  }

  updateChart(data, label) {
    const labels = Object.keys(data)
    const values = Object.values(data)
    const backgroundColors = this.generateColors(labels.length)
    this.chart.data.labels = labels;
    this.chart.data.datasets[0].data = values;
    this.chart.data.datasets[0].label = label;
    this.chart.data.datasets[0].backgroundColor = backgroundColors;
    this.chart.update();
  }

  setActiveButton(activeButton) {
    this.switchButtonTargets.forEach(button => {
      button.classList.remove('bg-white', 'text-indigo-600', 'shadow')
      button.classList.add('text-gray-600')
    })
    activeButton.classList.add('bg-white', 'text-indigo-600', 'shadow')
    activeButton.classList.remove('text-gray-600')
  }

  generateColors(count) {
    const colors = [
      '#4f46e5', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#3b82f6',
      '#06b6d4', '#d946ef', '#ec4899', '#f97316', '#a3e635', '#64748b'
    ]
    return Array.from({ length: count }, (_, i) => colors[i % colors.length]);
  }
}
