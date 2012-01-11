(function() {
  var n, sales, sum;
  sum = 0;
  sales = {
    east: [],
    west: []
  };
  for (n = 0; n <= 2000000; n++) {
    sales.west.push(10);
    sales.east.push(100.1);
  }
  console.log("Start");
  for (n = 0; n <= 2000000; n++) {
    sum += sales.west[n] + sales.east[n];
  }
  console.log("End");
  console.log("Sum is " + sum);
}).call(this);
