window.handleClick = function(event) {
  if (!event) return

  let time = new Date().getTime()
  let linkId = event.dataset.id
  let regexp = linkId ? new RegExp(linkId, 'g') : null
  let newFields = regexp ? event.dataset.fields.replace(regexp, time) : null

  newFields ? event.parentNode.firstElementChild.firstElementChild.insertAdjacentHTML('beforeend', newFields) : null
}