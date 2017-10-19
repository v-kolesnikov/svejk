# auto_register: false

require "rom-repository"
require "svejk/container"
require "svejk/import"

Svejk::Container.start :rom

module Svejk
  class Repository < ROM::Repository::Root
    include Svejk::Import.args["persistence.rom"]
  end
end
