module PublicHelper
  def format_money(num)
    (num.to_s + " <span style='color:orange'>$</span>").html_safe
  end
  
  def test
    true
  end

  def show_image(avatar)
    # puts "======================================="
    # puts avatar.inspect
    # puts "======================================="
    
    if avatar.present?
      ("<img src='#{avatar.url(:thumb)}'>").html_safe
    else
      ("<img src=''>").html_safe
    end
  end 

  def show_gender(gender)
    if gender == 0
      "nữ"
    elsif gender == 1
      "nam"
    else
      "3 đê"
    end
  end 
end
