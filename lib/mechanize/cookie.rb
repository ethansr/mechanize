if defined?(Mechanize::Error)
  # via autoload
  raise NameError, 'Mechanize::Cookie has been replaced with HTTP::Cookie.  Please migrate.'
else
  raise LoadError, 'mechanize/cookie has been replaced with the http-cookie gem.  Please migrate to HTTP::Cookie.'
end

# class Mechanize::Cookie < ::HTTP::Cookie
#   class << self
#     # See HTTP::Cookie.parse.
#     def parse(uri, set_cookie, log = nil)
#       warn '%s is deprecated.  Use %s.%s.' % [
#         self, superclass, __method__
#       ] if $VERBOSE
#       [].tap { |cookies|
#         superclass.parse(set_cookie, :origin => uri, :logger => log) { |hcookie|
#           cookie = allocate
#           hcookie.instance_variables.each { |name|
#             cookie.instance_variable_set(name, hcookie.instance_variable_get(name))
#           }
#           yield cookie if block_given?
#           cookies << cookie
#         }
#       }
#     end
#   end
#
#   # See HTTP::Cookie#domain=.
#   def set_domain(domain)
#     warn '%s is deprecated.  Use %s and replace #%s with #domain=.' % [
#       self.class, self.class.supersclass, __method__
#     ] if $VERBOSE
#     @domain = domain
#   end
# end
