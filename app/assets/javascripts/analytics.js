Morris.Area({
  element: 'analytics',
  data: $('#analytics').data('payments'),
  xkey: 'date',
  ykeys: ['price'],
  labels: ['Day Sales'],
  preUnits: "$"
});