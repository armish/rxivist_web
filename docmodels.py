class Documentation:
  def __init__(self, base_url, chapters = []):
    self.base_url = base_url
    self.chapters = chapters

class Chapter:
  def __init__(self, title, description=""):
    self.title = title
    self.description = description
    self.endpoints = []

  def add_endpoint(self, title, url, description = ""):
    new = Endpoint(title, url, description)
    self.endpoints.append(new)
    return new

class Endpoint:
  def __init__(self, title, url, description = ""):
    self.title = title
    self.url = url
    self.description = description
    self.path_arguments = [] # variables integrated into the URL itself
    self.get_arguments = []  # variables added as get parameters
    self.examples = []

  def add_argument(self, category, name, description, required=False):
    new = Argument(name, description, required)
    if category == "path":
      self.path_arguments.append(new)
    elif category == "get":
      self.get_arguments.append(new)
    else:
      raise Exception("Unrecognized argument type {}".format(category))
    return new

  def add_example(self, title, description, url, response=""):
    new = Example(title, description, url, response)
    self.examples.append(new)
    return new

class Argument:
  def __init__(self, name, description, default=None, required=False):
    self.name = name
    self.description = description
    self.default = default
    self.required = required

  def add_values(self, potential):
    "Adds information about acceptable values for an argument"
    self.acceptable = potential

class Example:
  def __init__(self, title, description, url, response=""):
    self.title = title
    self.url = url
    self.description = description
    self.response = response