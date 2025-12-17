import yaml

class SurikatOptions:
    def __init__(self, options_file="/app/options.yaml"):
        self.options_file = options_file
        self.load_options()

    def load_options(self):
        with open(self.options_file, "r") as f:
            self.options = yaml.safe_load(f)

    def get(self, key):
        return self.options.get(key)

    def all(self):
        return self.options
