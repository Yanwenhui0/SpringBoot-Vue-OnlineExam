<!-- 顶部信息栏 -->
<template>
  <header id="topbar">
    <el-row>
      <el-col :span="4" class="topbar-left">
        <i class="iconfont icon-kaoshi"></i>
        <span class="title" @click="index()">EXAM-SYSTEM</span>
      </el-col>
      <el-col :span="20" class="topbar-right">
        <i class="el-icon-s-fold" @click="toggle()"></i>
        <div class="user">
          <span @click="showSetting()">{{user.userName}}</span>
          <img src="@/assets/img/userimg.png" class="user-img" ref="img" @click="showSetting()" />
          <transition name="fade">
            <div class="out" ref="out" v-show="login_flag">
              <ul>
                <li @click="myInfo()"><a href="javascript:;"><i class="el-icon-user-solid"></i>我的信息</a></li>
                <li @click="mySetting()"><a href="javascript:;"><i class="el-icon-s-tools"></i>个人设置</a></li>
                <li class="exit" @click="exit()"><a href="javascript:;"><i class="el-icon-switch-button"></i>退出登录</a></li>
              </ul>
            </div>
          </transition>
        </div>
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

    <!-- 编辑对话框-->
    <el-dialog
      append-to-body
      title="修改密码"
      :before-close="handleClose"
      :visible.sync="dialogVisiblePassword"
      width="30%">
      <el-form :model="form" ref="resetP">
        <el-form-item label="原密码" :label-width="formLabelWidth" prop="oldPassword" required>
          <el-input placeholder="请输入原始密码" v-model="form.oldPassword" autofocus="true" show-password></el-input>
        </el-form-item>
        <el-form-item label="新密码" :label-width="formLabelWidth" prop="password" required>
          <el-input placeholder="请输入新密码" v-model="form.password" show-password></el-input>
        </el-form-item>
        <el-form-item label="确认密码" :label-width="formLabelWidth" prop="password2" required>
          <el-input placeholder="再次输入新密码" v-model="form.password2" show-password></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisiblePassword = false">取 消</el-button>
        <el-button type="primary" @click="updatePassword()">确 定</el-button>
      </div>
    </el-dialog>
  </header>
</template>

<script>
import store from '@/vuex/store'
import {mapState,mapMutations} from 'vuex'
export default {
  data() {
    return {
      dialogVisible: false,
      dialogVisiblePassword: false,
      login_flag: false,
      user: { //用户信息
        role:null,
        userName: null,
        userId: null
      },
        form: {
          adminId:'',
            teacherId:'',
            oldPassword: '',
            password: '',
            password2: '',
        },
        formLabelWidth: '80px'
    }
  },
  created() {
    this.getUserInfo()
  },
  computed: mapState(["flag","menu"]),
  methods: {
    validPassword(){
        if(this.form.oldPassword === '' || this.form.password === '' || this.form.password2 === ''){
            this.$message({
                message: '密码不能为空',
                type: 'warning'
            })
            return false;
        }
        if(this.form.password !== this.form.password2){
            this.$message({
                message: '两次密码输入不一致',
                type: 'warning'
            })
            return false;
        }
        return true;
    },
    updatePassword(){
        if(!this.validPassword()){
            return;
        }
        var url = '';
        if(this.$cookies.get("role") == 0) {
            url = '/api/admin/password'
            this.form.adminId = this.$cookies.get("cid")
        } else {
            url = '/api/teacher/password'
            this.form.teacherId = this.$cookies.get("cid")
        }
        this.$axios({
            url: url,
            method: 'put',
            data: {
                ...this.form
            }
        }).then(res=>{
            if(res.data.code == 200) {
            this.$message({ //成功修改提示
                message: '修改密码成功',
                type: 'success'
            })
            this.exit()
        } else {
          this.$refs.resetP.resetFields()
          this.$message({
              message: res.data.message,
              type: 'error'
          })
        }
        })
    },
    handleClose(done) {
        this.$confirm('确认关闭？')
            .then(_ => {
                done();
            })
            .catch(_ => {});
    },
    mySetting() { //个人信息
        this.dialogVisiblePassword = true;
        this.form.oldPassword = "";
        this.form.password = "";
        this.form.password2 = "";
    },
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
    //显示、隐藏退出按钮
    showSetting() {
      this.login_flag = !this.login_flag
    },
    //左侧栏放大缩小
    ...mapMutations(["toggle"]),
    getUserInfo() { //获取用户信息
      let userName = this.$cookies.get("cname")
      let userId = this.$cookies.get("cid")
      let role = this.$cookies.get("role")
      this.user.userName = userName
      this.user.userId = userId
      this.user.role = role
    },
    index() {
      this.$router.push({path: '/index'})
    },
    exit() {
      let role = this.$cookies.get("role")
      this.$router.push({path:"/"}) //跳转到登录页面
      this.$cookies.remove("cname") //清除cookie
      this.$cookies.remove("cid")
      this.$cookies.remove("role")
      if(role == 0) {
        this.menu.pop()
      }
    }
  },
  mounted() {
      document.addEventListener('click', e => {
          if (!this.$el.contains(e.target)) {
              this.login_flag = false //这句话的意思是点击其他区域关闭（也可以根据自己需求写触发事件）
          }
      })
  },
  store
}
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity .5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
#topbar {
  position: relative;
  z-index: 10;
  background-color: #3b5277;
  height: 80px;
  line-height: 80px;
  color: #fff;
  box-shadow: 5px 0px 10px rgba(0, 0, 0, 0.5);
}
#topbar .topbar-left {
  height: 80px;
  display: flex;
  justify-content: center;
  overflow: hidden;
}
.topbar-left .icon-kaoshi {
  margin-left: -70px;
  font-size: 60px;
}
.topbar-left .title {
  font-size: 20px;
  cursor: pointer;
}
.topbar-right {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.topbar-right .user-img {

}
.topbar-right .el-icon-s-fold {
  font-size: 30px;
  margin-left: -50px;
}
.topbar-right .user {
  position: relative;
  margin-right: 60px;
  display: flex;
  cursor: pointer;
}
.topbar-right .user .user-img {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  margin-top: 15px;
  margin-left: 10px;
}
.user .out {
  width: 120px;
  font-size: 14px;
  position: absolute;
  top: 80px;
  right: 0px;
  background-color: #fff;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
  padding: 10px;
}
.user .out ul {
  list-style: none;
}
.user .out ul > li {
  height: 30px;
  line-height: 26px;
}
.out a {
  text-decoration: none;
  color: #000;
}
.out a:hover{
  color: #0195ff;
}
.out i {
  padding: 0px 18px 0px 12px;
}
.out .exit {
  margin-top: 4px;
  padding-top: 8px;
  border-top: 1px solid #ccc;
}
.el-dialog label {
  display: block;
  height: 40px;
}
</style>
