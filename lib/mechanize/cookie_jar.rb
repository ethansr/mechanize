warn 'mechanize/cookie_jar is deprecated.  Please migrate to http/cookie_jar.' if $VERBOSE

require 'http/cookie_jar'
require 'http/cookie_jar/yaml_saver'
require 'mechanize/cookie'

class Mechanize
  module CookieJarIMethods
    include CookieDeprecated

    def add(arg1, arg2 = nil)
      if arg2
        __deprecated__ 'add and origin='
        super arg2.dup.tap { |ncookie|
          begin
            ncookie.origin = arg1
          rescue
            return nil
          end
        }
      else
        super arg1
      end
    end

    # See HTTP::CookieJar#add.
    def add!(cookie)
      __deprecated__ :add
      cookie.domain.nil? and raise NoMethodError, 'raised for compatibility'
      @store.add(cookie)
      self
    end

    # See HTTP::CookieJar#save.
    def save_as(filename, *options)
      __deprecated__ :save
      save(filename, *options)
    end

    # See HTTP::CookieJar#clear.
    def clear!
      __deprecated__ :clear
      clear
    end

    # See HTTP::CookieJar#store.
    def jar
      __deprecated__ :store
      @store.instance_variable_get(:@jar)
    end
  end

  CookieJar = ::HTTP::CookieJar

  class CookieJar
    module YAMLSaverIMethods
      def load(io, jar)
        begin
          data = YAML.load(io)
        rescue ArgumentError
          @logger.warn "unloadable YAML cookie data discarded" if @logger
          return
        end

        case data
        when Array
          data.each { |cookie|
            jar.add(cookie)
          }
        when Hash
          data.each { |domain, paths|
            paths.each { |path, names|
              names.each { |cookie_name, cookie|
                jar.add(cookie)
              }
            }
          }
        else
          @logger.warn "incompatible YAML cookie data discarded" if @logger
          return
        end
      end
    end
  end

  # Compatibility for Ruby 1.8/1.9
  unless CookieJar.respond_to?(:prepend, true)
    require 'mechanize/prependable'

    class CookieJar
      extend Prependable

      class YAMLSaver
        extend Prependable
      end
    end
  end

  class CookieJar
    prepend CookieJarIMethods

    class YAMLSaver
      prepend YAMLSaverIMethods
    end
  end
end
