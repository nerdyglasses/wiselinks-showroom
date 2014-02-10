module Wiselinks
  module Request
    def self.included(base)
      base.alias_method_chain :referer, :wiselinks
      base.alias_method_chain :referrer, :wiselinks
    end

    def referer_with_wiselinks
      self.headers['X-Wiselinks-Referer'] || self.referer_without_wiselinks
    end

    def referrer_with_wiselinks
      self.referer_with_wiselinks
    end

    def wiselinks?
      self.headers['X-Wiselinks'].present?
    end

    def wiselinks_template?
      self.wiselinks? && !wiselinks_partial? && !wiselinks_panel?
    end

    def wiselinks_partial?
      self.wiselinks? && self.headers['X-Wiselinks'] == 'partial'
    end

    def wiselinks_panel?
      # Wiselinks.log("wiselinks_panel? #{self.headers['X-Wiselinks']}")
      self.wiselinks? && self.headers['X-Wiselinks'] == 'panel'
    end

  end
end

