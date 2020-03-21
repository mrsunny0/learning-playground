package main

import (
	"flag"
	"fmt"
	"log"

	"github.com/currantlabs/gatt" // <- use fork
	_ "github.com/paypal/gatt"    // <- has l2cap invalid length bug
)

// GET NAME FROM ARGS
var deviceName = flag.String("device", "TEST", "device name")

// ON STATE CHANGE CALLBACK
func onStateChanged(d gatt.Device, state gatt.State) {
	switch state {
	case gatt.StatePoweredOn:
		fmt.Println("Scanning")
		d.Scan([]gatt.UUID{}, false)
		return
	default:
		d.StopScanning()
	}
}

// ON DISCOVERED PERIPHERAL CALLBACK
func onPeripheralDiscovered(peripheral gatt.Peripheral, advertisement *gatt.Advertisement, rssi int) {
	log.Println("Searching for device name: ", *deviceName)
	if advertisement.LocalName == *deviceName {
		log.Printf("Peripheral Discovered: %s \n", peripheral.Name())
		peripheral.Device().StopScanning()
		peripheral.Device().Connect(peripheral)
	}
}

// ON CONNECTED PERIPHERAL CALLBACK
func onPeripheralConnected(peripheral gatt.Peripheral, err error) {
	log.Println("CONNECTED")

	services, err := peripheral.DiscoverServices(nil)
	if err != nil {
		log.Printf("Failed to discover services, err: %s\n", err)
		return
	}

	// there are 5 services, empty service index [4] is custom, choose last index
	service := services[len(services)-1]
	characteristics, _ := peripheral.DiscoverCharacteristics(nil, service)

	// iterate through characteristics
	for _, c := range characteristics {
		peripheral.DiscoverDescriptors(nil, c)
		peripheral.SetNotifyValue(c, func(c *gatt.Characteristic, b []byte, e error) {
			log.Printf(string(b))
		})
	}
}

/********
 * MAIN *
 ********/
func main() {
	// parse input
	flag.Parse()

	// default options
	// device, err := gatt.NewDevice(option.DefaultClientOptions...)
	var DefaultClientOptions = []gatt.Option{
		gatt.LnxMaxConnections(1),
		gatt.LnxDeviceID(-1, false),
	}

	// create BLE device
	device, err := gatt.NewDevice(DefaultClientOptions...)
	if err != nil {
		log.Fatalf("Failed to open device, err: %s\n", err)
		return
	}

	// Handle functions
	device.Handle(
		gatt.PeripheralDiscovered(onPeripheralDiscovered),
		gatt.PeripheralConnected(onPeripheralConnected),
	)

	// Start
	device.Init(onStateChanged)
	select {}
}
