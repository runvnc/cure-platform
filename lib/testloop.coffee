sum = 0
sales =
  east: []
  west: []

for n in [0..2000000]
  sales.west.push 10
  sales.east.push 100.1

console.log "Start"
for n in [0..2000000]
  sum += sales.west[n] + sales.east[n]

console.log "End"
console.log "Sum is #{sum}"
