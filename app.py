import time
import yaml

with open("/app/options.yaml", "r") as f:
    options = yaml.safe_load(f)

print("Surikat HA démarre avec les options :")
print(options)

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    print("Surikat HA arrêté")
