import os
import yaml

class SurikatOptions:
    """
    Classe pour gérer les options de l'addon Surikat HA.
    Les options peuvent provenir de Home Assistant (self.options)
    ou du fichier options.yaml comme valeurs par défaut.
    """

    def __init__(self, options_file="/app/options.yaml"):
        self.options_file = options_file
        self.defaults = self.load_defaults()
        self.options = self.load_options()

    def load_defaults(self):
        """Charge les valeurs par défaut depuis options.yaml"""
        try:
            with open(self.options_file, "r") as f:
                return yaml.safe_load(f)
        except FileNotFoundError:
            # Si le fichier n'existe pas, utiliser des valeurs par défaut codées en dur
            return {
                "mqtt_host": "mqtt://localhost",
                "mqtt_port": 1883,
                "mqtt_topic": "frigate/events",
                "mqtt_user": "user",
                "mqtt_password": "password",
                "default_name": "Surikat"
            }

    def load_options(self):
        """Charge les options depuis les variables d'environnement si disponibles, sinon les valeurs par défaut"""
        opts = {}
        opts["mqtt_host"] = os.getenv("MQTT_HOST", self.defaults.get("mqtt_host"))
        opts["mqtt_port"] = int(os.getenv("MQTT_PORT", self.defaults.get("mqtt_port")))
        opts["mqtt_topic"] = os.getenv("MQTT_TOPIC", self.defaults.get("mqtt_topic"))
        opts["mqtt_user"] = os.getenv("MQTT_USER", self.defaults.get("mqtt_user"))
        opts["mqtt_password"] = os.getenv("MQTT_PASSWORD", self.defaults.get("mqtt_password"))
        opts["default_name"] = os.getenv("DEFAULT_NAME", self.defaults.get("default_name"))
        return opts

    def get(self, key):
        """Récupère la valeur d'une option"""
        return self.options.get(key)

    def all(self):
        """Retourne toutes les options sous forme de dictionnaire"""
        return self.options

# Exemple d'utilisation
if __name__ == "__main__":
    surikat_opts = SurikatOptions()
    print("Options chargées :")
    print(surikat_opts.all())
