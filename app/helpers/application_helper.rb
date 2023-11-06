include ActionView::Helpers::NumberHelper
include ActionView::Helpers::DateHelper
include ActionView::Helpers::TextHelper

module ApplicationHelper
  def validate_params(param = nil)
    if param.present?
      param
    else
      return http_status(404)
    end
  rescue
    return http_status(404)
  end

  def message_validation(message)
    message.gsub("#{I18n.t(:validation_failed)}: ", '').split(', ').first.capitalize
  end

  def http_status_codes(code)
    case code
      when 100
        I18n.t(:status_code_100)
      when 101
        I18n.t(:status_code_101)
      when 102
        I18n.t(:status_code_102)
      when 200
        I18n.t(:status_code_200)
      when 201
        I18n.t(:status_code_201)
      when 202
        I18n.t(:status_code_202)
      when 203
        I18n.t(:status_code_203)
      when 204
        I18n.t(:status_code_204)
      when 205
        I18n.t(:status_code_205)
      when 206
        I18n.t(:status_code_206)
      when 207
        I18n.t(:status_code_207)
      when 208
        I18n.t(:status_code_208)
      when 226
        I18n.t(:status_code_226)
      when 300
        I18n.t(:status_code_300)
      when 301
        I18n.t(:status_code_301)
      when 302
        I18n.t(:status_code_302)
      when 303
        I18n.t(:status_code_303)
      when 304
        I18n.t(:status_code_304)
      when 305
        I18n.t(:status_code_305)
      when 307
        I18n.t(:status_code_307)
      when 308
        I18n.t(:status_code_308)
      when 400
        I18n.t(:status_code_400)
      when 401
        I18n.t(:status_code_401)
      when 402
        I18n.t(:status_code_402)
      when 403
        I18n.t(:status_code_403)
      when 404
        I18n.t(:status_code_404)
      when 405
        I18n.t(:status_code_405)
      when 406
        I18n.t(:status_code_406)
      when 407
        I18n.t(:status_code_407)
      when 408
        I18n.t(:status_code_408)
      when 409
        I18n.t(:status_code_409)
      when 410
        I18n.t(:status_code_410)
      when 411
        I18n.t(:status_code_411)
      when 412
        I18n.t(:status_code_412)
      when 413
        I18n.t(:status_code_413)
      when 414
        I18n.t(:status_code_414)
      when 415
        I18n.t(:status_code_415)
      when 416
        I18n.t(:status_code_416)
      when 417
        I18n.t(:status_code_417)
      when 421
        I18n.t(:status_code_421)
      when 422
        I18n.t(:status_code_422)
      when 423
        I18n.t(:status_code_423)
      when 424
        I18n.t(:status_code_424)
      when 426
        I18n.t(:status_code_426)
      when 428
        I18n.t(:status_code_428)
      when 429
        I18n.t(:status_code_429)
      when 431
        I18n.t(:status_code_431)
      when 451
        I18n.t(:status_code_451)
      when 500
        I18n.t(:status_code_500)
      when 501
        I18n.t(:status_code_501)
      when 502
        I18n.t(:status_code_502)
      when 503
        I18n.t(:status_code_503)
      when 504
        I18n.t(:status_code_504)
      when 505
        I18n.t(:status_code_505)
      when 506
        I18n.t(:status_code_506)
      when 507
        I18n.t(:status_code_507)
      when 508
        I18n.t(:status_code_508)
      when 510
        I18n.t(:status_code_510)
      when 511
        I18n.t(:status_code_511)
      else
        nil
    end
  end

  def xrand
    rand(10 ** 100).to_s
  end

  def rand_number(digit = nil)
    return xrand[1..digit] if digit.present?

    xrand[1..15]
  rescue
    xrand[1..15]
  end

  def format_money(amount)
    number_to_currency(amount.to_i, unit: 'Rp', delimiter: '.', precision: 0, format: '%u%n,-')
  end

  def generate_expired_jwt
    if Rails.env.staging?
      24.hours.from_now
    else
      2.hours.from_now
    end
  end

end
