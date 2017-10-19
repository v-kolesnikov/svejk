module Test
  module DatabaseHelpers
    module_function

    def rom
      Svejk::Container["persistence.rom"]
    end

    def db
      Svejk::Container["persistence.db"]
    end
  end
end
