module TFA
  module TfaHelper
    def require_tfa(
      url:,
      method: :post,
      http_params: {},
      phone_number:,
      message: "Your two factor authentication code is:\n\n{code}",
      length: 6
    )
      @tfa = Tfa.new
      @tfa.phone = phone_number
      @tfa.used = false

      http_params_ = ""
      http_params.each do |p|
        http_params_ << "#{p[0]}:#{p[1].gsub(':', "\0001").gsub(',', "\0002").gsub('#', "\0003")},"
      end

      @tfa.after = "#{method}###{url}###{http_params_}"
      @tfa.code = rand((10**(length-1))..("9"*length).to_i)
      @tfa.save

      Twilio.send_msg(
        message.gsub("{code}", @tfa.code.to_s),
        to: phone_number
      )

      controller.redirect_to Engine.routes.url_helpers.tfa_verify_path(@tfa)
    end

    def if_tfa(&block)
      if params[:tfa_id] && Tfa.find_by(id: params[:tfa_id]).code.to_s == params[:code].to_s && !Tfa.find_by(id: params[:tfa_id]).used
        @tfa = Tfa.find_by(id: params[:tfa_id])
        @tfa.used = true
        @tfa.save

        block.call(@tfa)
      end
    end

    def no_tfa(&block)
      if !params[:tfa_id]
        block.call
      elsif Tfa.find_by(id: params[:tfa_id]).code.to_s != params[:code].to_s
        block.call
      end
    end

    def tfa_friendly_params(p)
      p.permit!
      p = p.to_h
      out = {}

      p.each do |param|
        if param[1].class != ActiveSupport::HashWithIndifferentAccess
          out[param[0]] = param[1]
        else
          param[1].each do |p1|
            out["#{param[0]}[#{p1[0]}]"] = p1[1]
          end
        end
      end

      return out
    end
  end
end
