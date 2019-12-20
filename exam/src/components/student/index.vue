<!--学生考试首页-->
<template>
  <div id="student">
    <el-row class="padding-50">
      <el-col :span="24">
        <ul class="list">
          <li class="logo"><i class="iconfont icon-kaoshi"></i><span>Exam-Online</span></li>
          <li @click="exam()"><a href="javascript:;">我的试卷</a></li>
          <li @click="practice()"><a href="javascript:;">我的练习</a></li>
          <li><router-link to="/scoreTable">我的分数</router-link></li>
          <li><a href="javascript:;">写下笔记</a></li>
          <li><a href="javascript:;">收藏经典</a></li>
          <li><router-link to="/message">留言板</router-link></li>
          <li class="right" @mouseenter="flag = !flag" @mouseleave="flag = !flag">
            <a href="javascript:;"><i class="iconfont icon-Userselect icon"></i>{{user.userName}}</a>
            <div class="msg" v-if="flag">
              <p @click="myInfo()">我的信息</p>
              <p @click="manage()">个人设置</p>
              <p class="exit" @click="exit()">退出</p>
            </div>
          </li>
        </ul>
      </el-col>
    </el-row>

    <!-- 编辑对话框-->
    <el-dialog
      append-to-body
      title="我的信息"
      :visible.sync="dialogVisible"
      width="30%">
      <label>姓名：{{user.userName}}</label>
      <label v-if="user.sex">性别：{{user.sex}}</label>
      <label>电话：{{user.tel}}</label>
      <label>邮箱：{{user.email}}</label>
      <label v-if="user.grade">年级：{{user.grade}}</label>
      <label v-if="user.institute">学院：{{user.institute}}</label>
      <label v-if="user.major">专业：{{user.major}}</label>
      <label v-if="user.clazz">班级：{{user.clazz}}</label>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
      </span>
    </el-dialog>

    <!--路由区域-->
    <div class="main">
      <router-view></router-view>
    </div>
    <v-footer></v-footer>
  </div>
</template>

<script>
import myFooter from "@/components/student/myFooter"
import store from '@/vuex/store'
import {mapState} from 'vuex'
export default {
  store,
  components: {
    "v-footer": myFooter
  },
  data() {
    return {
      dialogVisible: false,
      flag: false,
      user: {}
    }
  },
  created() {
    this.userInfo()
  },
  methods: {
    myInfo() { //个人信息
        this.dialogVisible = true
        switch(this.$cookies.get("role")) {
            case "0":  //管理员
                this.user.tel = this.$cookies.get("tel")
                this.user.email = this.$cookies.get("email")
                break
            case "1": //教师
                this.user.tel = this.$cookies.get("tel")
                this.user.email = this.$cookies.get("email")
                this.user.institute = this.$cookies.get("institute")
                break
            case "2": //学生
                this.user.tel = this.$cookies.get("tel")
                this.user.email = this.$cookies.get("email")
                this.user.institute = this.$cookies.get("institute")
                this.user.grade = this.$cookies.get("grade")
                this.user.major = this.$cookies.get("major")
                this.user.clazz = this.$cookies.get("clazz")
                this.user.sex = this.$cookies.get("sex")
                break
        }
    },
    exit() {  //退出登录
      this.$router.push({path:"/"}) //跳转到登录页面
      this.$cookies.remove("cname") //清除cookie
      this.$cookies.remove("cid")
    },
    manage() {  //跳转到修改密码页面
      this.$router.push({path: '/manager'})
    },
    userInfo() {
      let studentName = this.$cookies.get("cname")
      let studentId = this.$cookies.get("cid")
      console.log(`studentId${studentId}`)
      console.log(`studentName ${studentName}`)
      this.user.userName = studentName
      this.user.studentId = studentId
    },
    practice() { //跳转练习模式
      let isPractice = true
      this.$store.commit("practice", isPractice)
      this.$router.push({path:'/startExam'})
    },
    exam() { //跳转考试模式
     let isPractice = false
      this.$store.commit("practice", isPractice)
      this.$router.push({path:'/student'})
    }
  },
  computed:mapState(["isPractice"])
}
</script>

<style scoped>
.right .icon {
  margin-right: 6px;
}
#student .padding-50 {
  margin: 0 auto;
  padding: 0 50px;
  box-shadow: 0 0 10px 4px rgba(1,149,255,0.1);
  background-color: #fff;
}
.list a {
  text-decoration: none;
  color: #334046;
}
li {
  list-style: none;
  height: 60px;
  line-height: 60px;
}
#student .list{
  display: flex;
}
#student .list li {
  padding: 0 20px;
  cursor: pointer;
}
#student .list li:hover {
  background-color: #0195ff;
  transition: all 2s ease;
}
#student .list li:hover a {
  color: #fff;
}
#student .list .right {
  margin-left: auto;
  position: relative;
}
#student .list li.right :hover a {
  color: #000;
}
#student .list .logo {
  display: flex;
  font-weight: bold;
  color: #2f6c9f;
}
#student .list .logo i {
  font-size: 50px;
}
.right .msg {
  width: 100%;
  text-align: center;
  position: absolute;
  top: 60px;
  left: 0px;
  display: flex;
  flex-direction: column;
  border-radius: 15px;
  border-bottom: 3px solid #aea893;
  background-color: #fff;
}
.right .msg p {
  height: 40px;
  line-height: 40px;
  width: 100%;
}
.right .msg p:hover {
  border-radius: 15px;
  background-color: #0195ff;
  color: #fff;
}
.el-dialog label {
  display: block;
  height: 40px;
}
</style>
