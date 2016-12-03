require 'acceptance_helper'

resource "管理员对 课程表 相关的API" do
  header "Accept", "application/json"

  #################### create #############################
  post '/syllabuses' do
    # admin_attrs = FactoryGirl.attributes_for(:admin)
    syllabus_attrs = FactoryGirl.attributes_for(:syllabus)

    # header "X-Admin-Token", admin_attrs[:authentication_token]
    # header "X-Admin-Email", admin_attrs[:email]
    parameter :title, " 课程表 课程的标题",required: true, scope: :syllabus
    parameter :training_course_id, "课程表 课程 属于的项目",required: true, scope: :syllabus
    parameter :school_id, "课程表 课程属于的 学校",required: true, scope: :syllabus
    parameter :course_time, "课程表 课程的开课 时间",required: true, scope: :syllabus
    parameter :content, "课程表 课程简介",required: true, scope: :syllabus

    let(:title) {syllabus_attrs[:title]}
    let(:training_course_id) {syllabus_attrs[:training_course_id]}
    let(:school_id) {syllabus_attrs[:school_id]}
    let(:course_time) {syllabus_attrs[:course_time]}
    let(:content) {syllabus_attrs[:content]}

    before do
      # @admin = create(:admin)
      # @school = create(:school)
      # @training_course = create(:training_course)
    end

    example "管理员 创建课程表 成功" do
      do_request
      puts response_body
      expect(status).to eq(201)
    end
  end

  ############### before_do ################################
  describe 'syllabus condition is all correct' do
    # admin_attrs = FactoryGirl.attributes_for(:admin)

    # header "X-Admin-Token", admin_attrs[:authentication_token]
    # header "X-Admin-Email", admin_attrs[:email]

    before do
      # @school = create(:school)
      @syllabuses = create_list(:syllabus, 5, course_time: Time.zone.now)
    end

    #################### index #############################
    get '/syllabuses' do

      parameter :page, "当前页", required: false
      parameter :per_page, "每页的数量", required: false
   
      let(:page) {1}
      let(:per_page) {6}

      example "管理员 查询 课程表 记录 成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end

    ##################### show #############################
    get "/syllabuses/:id" do

      let(:id) {@syllabuses.first.id}

      example " 管理员 查询指定 课程表 的详情成功" do
        do_request
        puts response_body
        expect(status).to eq(200)
      end
    end
    ##################### update #############################
    put "/syllabuses/:id" do

      let(:id) {@syllabuses.first.id}

      syllabus_attrs = FactoryGirl.attributes_for(:syllabus)

      parameter :title, " 课程表 课程的标题",required: true, scope: :syllabus
      parameter :training_course_id, "课程表 课程 属于的项目",required: true, scope: :syllabus
      parameter :school_id, "课程表 课程属于的 学校",required: true, scope: :syllabus
      parameter :course_time, "课程表 课程的开课 时间",required: true, scope: :syllabus
      parameter :content, "课程表 课程简介",required: true, scope: :syllabus

      let(:title) {syllabus_attrs[:title]}
      let(:training_course_id) {syllabus_attrs[:training_course_id]}
      let(:school_id) {syllabus_attrs[:school_id]}
      let(:course_time) {syllabus_attrs[:course_time]}
      let(:content) {syllabus_attrs[:content]}

      example " 管理员 修改指定 课程表 成功" do
        do_request
        puts response_body
        expect(status).to eq(201)
      end
    end

    ##################### delete #############################
    delete "/syllabuses/:id" do

      let(:id) {@syllabuses.first.id}

      example " 管理员 删除指定 课程表 成功" do
        do_request
        puts response_body
        expect(status).to eq(204)
      end
    end

  end
end