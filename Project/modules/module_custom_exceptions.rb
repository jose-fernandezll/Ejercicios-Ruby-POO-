# frozen_string_literal: true

# Module Custom Exception
module CustomExceptions
  class NotLoggedInError < StandardError; end
  class NotAdminError < StandardError; end
  class RequireValues < StandardError; end

end
