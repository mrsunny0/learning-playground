var noble = require('@abandonware/noble');

noble.on('stateChange', function(state) {
  if (state === 'poweredOn') {
    noble.startScanning();
    console.log('start scanning');
  } else {
    noble.stopScanning();
    console.log('stop scanning');
  }
});

noble.on('discover', function(peripheral) {
	var name = peripheral.advertisement.localName;
	if (name === "NHELMET") {
		  peripheral.connect(function(error) {
	    console.log('connected to peripheral: ' + peripheral.uuid);

	    peripheral.discoverServices([], function(error, services) {
	      console.log('discovered the following services:');
	      for (var i in services) {
	        console.log('  ' + i + ' uuid: ' + services[i].uuid);
	      }

	      var service = services[0];
	      service.discoverCharacteristics([], function(err, characteristics) {
	      	characteristics.forEach(function(c) {
	      		c.read(function(error, buffer) {
	      			console.log(buffer.toString('utf8'));
	      		})
	      	})
	      })

	    });
	  });
	}
});