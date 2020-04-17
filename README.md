  <% if params[:search].present? %>
    <h1>検索結果</h1>
  <% else %>
    <h1>ユーザー一覧</h1>
  <% end %>    
<div class="row container">
  <div class="col-md-4 col-md-offset-8">
    <%= form_with(class: 'search_form', method: :get, local: true) do |f| %>
      <%= f.label :name, 'ユーザー名検索', class: "label-signup" %>
      <%= f.text_field :search, class: 'form-control', value: params[:search], placeholder: "検索君" %>
      <%= f.submit '検索する', class: "btn btn-sm btn-primary" %>
    <% end %>
  </div>
</div>
    
  
<div class="col-md-10 col-md-offset-1">
  <%= will_paginate %>
  <table class="table table-condensed table-hover" id="table-users">
    <thead>
      <tr>
        <th><%= User.human_attribute_name :name %></th>
        <th class="center"><%= User.human_attribute_name :department %></th>
        <% if current_user.admin? %>
          <th class="center"><%= User.human_attribute_name :basic_time %></th>
          <th class="center"><%= User.human_attribute_name :work_time %></th>
        <% end %>
        <th></th>
      </tr>
    </thead>
    
    <% @users.each do |user| %>
      <tr>
        <td>
          <% if current_user.admin? %>
            <%= link_to user.name, user %>
          <% else %>
            <%= user.name %>
          <% end %>
        </td>
        <td class="center"><%= user.department.present? ? user.department : "未所属" %></td>
        <% if current_user.admin? %>
          <td class="center"><%= format_basic_info(user.basic_time) %></td>
          <td class="center"><%= format_basic_info(user.work_time) %></td>
        <% end %>
        <td class="center">
            <%= link_to "基本情報編集", edit_basic_info_user_path(user), remote: true, class: "btn btn-success" %>
          <% if current_user.admin? && !current_user?(user) %>
            <%= link_to "削除", user, method: :delete,
                data: { confirm: "削除してもよろしいですか？"}, class: "btn btn-danger" %>
          <% end %>
        </td>
      </tr>
    <% end %>
  </table>
  <% will_paginate %>
</div>

<!--モーダルウインドウ-->
<div id="edit-basic-info" class="modal fade" tabindex="-1" role="dialog" area-hidden="true"></div>
ja:
  activerecord:
    models:
      user: ユーザー
    attributes:
        user:
          id: ID
          name: 名前
          email: メールアドレス
          affiliation: 所属
          basic_time: 基本時間
          work_time: 勤務時間
          password: パスワード
          password_confirmation: パスワード再入力
          created_at: 作成日
          updated_at: 更新日
          designated_work_start_time: 指定勤務開始時間
          basic_work_time: 基本時間
          designated_work_end_time: 指定勤務終了時間
        attendance:
          worked_on: 日付
          started_at: 出勤時間
          finished_at: 退勤時間
          note: 備考
          user: ユーザー
        base:
          base_name: 社員番号
          base_number: 拠点名
          base_kind: 勤怠種類