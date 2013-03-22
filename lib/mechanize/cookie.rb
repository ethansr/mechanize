warn 'mechanize/cookie is deprecated.  Please migrate to http/cookie.' if $VERBOSE

require 'http/cookie'

class Mechanize
  module CookieDeprecated
    def __deprecated__(to = nil)
      $VERBOSE or return
      method = caller[0][/([^`]+)(?='$)/]
      to ||= method
      case self
      when Class
        lname = name[/[^:]+$/]
        klass = 'Mechanize::%s' % lname
        this = '%s.%s' % [klass, method]
        that = 'HTTP::%s.%s' % [lname, to]
      else
        lname = self.class.name[/[^:]+$/]
        klass = 'Mechanize::%s' % lname
        this = '%s#%s' % [klass, method]
        that = 'HTTP::%s#%s' % [lname, to]
      end
      warn '%s: The call of %s needs to be fixed to follow the new API (%s).' % [caller[1], this, that]
    end
    private :__deprecated__
  end

  module CookieCMethods
    include CookieDeprecated

    def parse(arg1, arg2 = nil, *args, &block)
      if arg2.is_a?(String)
        __deprecated__
        if args.size > 1
          raise ArgumentError, "wrong number of arguments (#{2 + args.size} for 1-3)"
        end
        super(arg2, { :origin => arg1, :logger => args.first })
      else
        super
      end
    end
  end

  module CookieIMethods
    include CookieDeprecated

    def set_domain(domain)
      __deprecated__ :domain=
      @domain = domain
    end
  end

  Cookie = ::HTTP::Cookie

  # Compatibility for Ruby 1.8/1.9
  unless Cookie.respond_to?(:prepend, true)
    require 'mechanize/prependable'

    class Cookie
      extend Prependable

      class << self
        extend Prependable
      end
    end
  end

  class Cookie
    prepend CookieIMethods

    class << self
      prepend CookieCMethods
    end
  end
end
