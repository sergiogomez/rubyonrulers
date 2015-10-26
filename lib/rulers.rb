require "rulers/array"
require "rulers/version"
require "rulers/routing"

module Rulers
  class Application
    def call(env)
      begin
        return [404, {'Content-Type' => 'text/html'}, []] if env['PATH_INFO'] == '/favicon.ico'
        return [301, {'Location' => '/quotes/a_quote'}, []] if env['PATH_INFO'] == '/'

        klass, act = get_controller_and_action(env)
        controller = klass.new(env)
        text = controller.send(act)
        [200, {'Content-Type' => 'text/html'},
          [text]
        ]
      rescue Exception => e
        return [500, {'Content-Type' => 'text/html'}, ["#{e}"]] 
      end
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
