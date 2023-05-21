#include <DFRobot_HX711_I2C.h>

#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>

#include <addons/RTDBHelper.h>

// #define WIFI_SSID "John"
// #define WIFI_PASSWORD "123454321"
#define WIFI_SSID "Benson12"
#define WIFI_PASSWORD "123454321"

#define DATABASE_URL "elec5518-7d7c2-default-rtdb.asia-southeast1.firebasedatabase.app" //<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
FirebaseJson fjson;
FirebaseJson timejson;
unsigned long dataMillis = 0;
int count = 0;

// DFRobot_HX711_I2C WS(&Wire,/*addr=*/0x64);
DFRobot_HX711_I2C WS;

// Echo_D3 Trig_D4
const int EchoPin = 10;
const int TrigPin = 15;
long Time_Echo = 0;
long Len_cm = 0;

int LED = 2;

void setup() {
    Serial.begin(115200);

    WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
    Serial.print("Connecting to Wi-Fi");
    unsigned long ms = millis();
    while (WiFi.status() != WL_CONNECTED) {
        Serial.print(".");
        delay(300);
    }
    Serial.println();
    Serial.print("Connected with IP: ");
    Serial.println(WiFi.localIP());
    Serial.println();

    Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

    config.database_url = DATABASE_URL;
    config.signer.test_mode = true;

    Firebase.reconnectWiFi(true);

    Firebase.begin(&config, &auth);

    pinMode(LED, OUTPUT);
    pinMode(EchoPin, INPUT);
    pinMode(TrigPin, OUTPUT);

    // Weight Sensor
    while (!WS.begin()) {
        Serial.println("The initialization of the chip is failed, please confirm whether the chip connection is correct");
        delay(1000);
    }
    // Manually set the calibration values
    WS.setCalibration(2236.f);
    // remove the peel
    WS.peel();
}

void loop() {

    // Weight Sensor
    float weight = WS.readWeight();
    if (weight <= 0) {
        weight = 0;
    }
    Serial.print("weight is: ");
    Serial.print(weight / 1000, 1);
    Serial.println(" kg");

    // Distance Sensor
    digitalWrite(TrigPin, LOW);
    digitalWrite(TrigPin, HIGH);
    delay(10);
    digitalWrite(TrigPin, LOW);

    Time_Echo = pulseIn(EchoPin, HIGH);
    if ((Time_Echo < 60000) && (Time_Echo > 1)) {
        Len_cm = (Time_Echo * 34 / 100) / 20;
        if (Len_cm > 30) {
            Len_cm = 30;
        }
        Serial.print("Present Distance is: ");
        Serial.print(Len_cm, DEC);
        Serial.println("cm");
    } else {
        Serial.println("Error! Too long or too short");
    }

    fjson.set("depth", Len_cm);
    fjson.set("fullDepth", 30);
    fjson.set("fullness", 1.0 - (Len_cm / 30.0));
    Serial.println(1.0 - (Len_cm / 30));
    fjson.set("location", "F07 0117"); // building name + sensor ID
    fjson.set("power", 0.7);
    // fjson.set("timestamp", 1685044800000); // time stamp, may get time from somewhere
    timejson.set (".sv","timestamp");
    fjson.set("timestamp", timejson); // time stamp, may get time from somewhere
    fjson.set("weight", weight / 1000.0);
    if (Firebase.pushJSON(fbdo, "/buildings/USYD/F07/L1/0117", fjson)) {

        Serial.println(fbdo.dataPath());
        Serial.println(fbdo.pushName());
        Serial.println(fbdo.dataPath() + "/" + fbdo.pushName());
    } else {
        Serial.println(fbdo.errorReason());
    }

    // LED BLINK
    digitalWrite(LED, HIGH);
    delay(10000);
    digitalWrite(LED, LOW);
}
