const form = document.getElementById('search-bike-form')

form.addEventListener('submit', function (e) {
  const input = document.getElementById('size').value
  const result = document.getElementById('result')
  const url = "/entries?utf8=✓&query=" + input

  e.preventDefault()

  result.innerHTML = "Chargement..."
  const httpRequest = new XMLHttpRequest();
  httpRequest.onreadystatechange = function () {
    if (httpRequest.readyState === 4) {
      result.innerHTML = httpRequest.responseText
    }
  }
  httpRequest.open('GET', url, true)
  httpRequest.send()
})


