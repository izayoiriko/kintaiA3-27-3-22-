module ApplicationHelper
  # ページごとにタイトルを返す
  def full_title(page_name = "")
    base_title = "AttendanceApp"  
    if page_name.mpty? # boolean値
      base_title # 空の場合の処理
    else
      page_name + " | " + base_title # 文字列連結
    end
  end
end
