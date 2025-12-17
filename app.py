import argparse
import time
import paho.mqtt.client as mqtt

parser = argparse.ArgumentParser()
parser.add_argument("--mqtt_host", required=True)
parser.add_argument("--mqtt_port", type=int, required=True)
parser.add_argument("--mqtt_topic", required=True)
parser.add_argument("--mqtt_user", required=True)
parser.add_argument("--mqtt_password", required=True)
args = parser.parse_args()

def on_connect(client, userdata, flags, rc):
    print("Connecté au broker MQTT avec code :", rc)
    client.subscribe(args.mqtt_topic)

def on_message(client, userdata, msg):
    print(f"Message reçu sur {msg.topic} : {msg.payload.decode()}")

client = mqtt.Client()
client.username_pw_set(args.mqtt_user, args.mqtt_password)
client.on_connect = on_connect
client.on_message = on_message
client.connect(args.mqtt_host.replace("mqtt://",""), args.mqtt_port, 60)
client.loop_start()

print("Surikat HA démarre...")

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    print("Surikat HA arrêté")
