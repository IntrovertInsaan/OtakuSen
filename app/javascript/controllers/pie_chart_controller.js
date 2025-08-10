import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js'
Chart.register(...registerables);

export default class extends Controller {
  connect() {
    // Get the data passed from the Rails view
    const data = JSON.parse(this.element.dataset.statusData)
    const labels = Object.keys(data)
    const values = Object.values(data)

    // Initialize a new chart
    new Chart(this.element, {
      type: 'pie',
      data: {
        labels: labels,
        datasets: [{
          label: 'Items by Status',
          data: values,
          backgroundColor: [
            'rgb(54, 162, 235)',  // Blue
            'rgb(75, 192, 192)',  // Green
            'rgb(255, 205, 86)',  // Yellow
            'rgb(255, 99, 132)',   // Red
            'rgb(153, 102, 255)'  // Purple
          ],
          hoverOffset: 4
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
      }
    });
  }
}