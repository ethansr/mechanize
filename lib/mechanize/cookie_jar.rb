if defined?(Mechanize::Error)
  # via autoload
  raise NameError, 'Mechanize::CookieJar has been replaced with HTTP::CookieJar.  Please migrate to HTTP::Cookie and HTTP::CookieJar.'
else
  raise LoadError, 'mechanize/cookie_jar has been replaced with the http-cookie gem.  Please migrate to HTTP::CookieJar and HTTP::Cookie.'
end

# # Mechanize::CookieJar will be replaced with HTTP::CookieJar soon.
# class Mechanize::CookieJar < ::HTTP::CookieJar
#   def __deprecated__(message = nil)
#     warn '%s is deprecated.  Use %s%s.' % [
#       self.class, self.class.supersclass, message ? ' and ' << message : ''
#     ] if $VERBOSE
#   end
#   private :__deprecated__
#
#   # See HTTP::CookieJar#add and HTTP::CookieJar#origin.
#   def add(uri, cookie)
#     __deprecated__ 'replace #%s(uri, cookie) with #add(cookie)' % __method__
#     super cookie.dup.tap { |ncookie|
#       begin
#         ncookie.origin = uri
#       rescue
#         return nil
#       end
#     }
#   end
#
#   # See HTTP::CookieJar#add.
#   def add!(cookie)
#     __deprecated__ 'replace #%s with #add' % __method__
#     cookie.domain.nil? and raise NoMethodError, 'raised for compatibility'
#     @store.add(cookie)
#     self
#   end
#
#   # See HTTP::CookieJar#save.
#   def save_as(filename, *options)
#     __deprecated__ 'replace #%s with #save' % __method__
#     save(filename, *options)
#   end
#
#   # See HTTP::CookieJar#clear.
#   def clear!
#     __deprecated__ 'replace #%s with #clear' % __method__
#     clear
#   end
# end
