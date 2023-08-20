import os
from dotenv import load_dotenv
import CoreLocation
from Foundation import NSDate
from geopy.distance import distance

lat = None
lon = None

# Load .env file
load_dotenv()


def get_location():
    location_manager = CoreLocation.CLLocationManager.alloc().init()
    location_delegate = LocationDelegate.alloc().init()
    location_manager.setDelegate_(location_delegate)
    location_manager.startUpdatingLocation()

    location_loop = CoreLocation.NSRunLoop.currentRunLoop()
    location_loop.runUntilDate_(NSDate.dateWithTimeIntervalSinceNow_(0.01))


class LocationDelegate(CoreLocation.NSObject):
    def locationManager_didUpdateLocations_(self, manager, locations):
        global lat, lon
        location = locations.lastObject()
        latitude = location.coordinate().latitude
        longitude = location.coordinate().longitude

        lat, lon = latitude, longitude


if __name__ == "__main__":
    get_location()

    # get home lat and lon from .env file
    latHome = os.getenv("HOME_LAT")
    lonHome = os.getenv("HOME_LON")

    # Calculate the distance between two coordinates
    dist = distance((latHome, lonHome), (lat, lon)).meters

    if dist < 100:
        print('{"status": "home"}')
    else:
        print('{"status": "away"}')
