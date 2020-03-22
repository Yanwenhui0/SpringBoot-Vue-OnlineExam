<!-- 添加学生 -->
<template>
  <section class="add">
    <el-form ref="form" :model="form" :rules="rules" label-width="80px">
      <el-form-item label="姓名" required prop="studentName">
        <el-input v-model="form.studentName"></el-input>
      </el-form-item>
      <el-form-item label="性别" required>
        <el-input v-model="form.sex"></el-input>
      </el-form-item>
      <el-form-item label="学院" required>
        <el-input v-model="form.institute"></el-input>
      </el-form-item>
      <el-form-item label="所属专业" required>
        <el-input v-model="form.major"></el-input>
      </el-form-item>
      <el-form-item label="年级" required>
        <el-input v-model="form.grade"></el-input>
      </el-form-item>
      <el-form-item label="班级" required>
        <el-input v-model="form.clazz"></el-input>
      </el-form-item>
      <el-form-item label="电话号码" required prop="tel">
        <el-input v-model="form.tel"></el-input>
      </el-form-item>
      <el-form-item label="身份证号" required prop="cardId">
        <el-input v-model="form.cardId"></el-input>
      </el-form-item>
      <el-form-item label="邮箱" required prop="email">
        <el-input v-model="form.email"></el-input>
      </el-form-item>
      <el-form-item label="密码" required prop="pwd">
        <el-input v-model="form.pwd" type="password"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit()">立即创建</el-button>
        <el-button type="text" @click="cancel()">取消</el-button>
      </el-form-item>
    </el-form>
  </section>
</template>

<script>
export default {
  data() {
      var checkEmail = (rule, value, callback) => {
          const mailReg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.com)/
          if (!value) {
              return callback(new Error('邮箱不能为空'))
          }
          setTimeout(() => {
              if (mailReg.test(value)) {
                  callback()
              } else {
                  callback(new Error('请输入正确的邮箱格式'))
              }
          }, 100)
      };
    return {
      rules: {
        studentName: [{required: true, message:"姓名不能为空", trigger: 'blur'}],
        email: [
            {required: true, message:"邮箱不能为空", trigger: 'blur'},
            {validator: checkEmail, trigger: 'blur'}
        ],
        tel:[
            {required: true, message:"电话不能为空", trigger: 'blur'},
            {min: 11, max: 11, message:"请输入正确的电话号码", trigger: 'blur'}
        ],
        cardId:[
          {required: true, message:"身份证不能为空", trigger: 'blur'},
          {min: 18, max: 18, message:"请输入正确的身份证号码", trigger: 'blur'}
        ],
        pwd: [
            {required: true, message:"密码不能为空", trigger: 'blur'},
            {min: 6, message:"密码长度不少于6位", trigger: 'blur'},
            {max: 18, message:"密码长度不多于18位", trigger: 'blur'},
        ]
      },
      form: { //表单数据初始化
        studentName: null,
        grade: null,
        major: null,
        studentClazz: null,
        institute: null,
        tel: null,
        email: null,
        pwd: null,
        cardId: null,
        sex: null,
        role: 2
      }
    };
  },
  methods: {
    onSubmit() { //数据提交
      this.$axios({
        url: '/api/student',
        method: 'post',
        data: {
          ...this.form
        }
      }).then(res => {
        if(res.data.code == 200) {
          this.$message({
            message: '数据添加成功',
            type: 'success'
          })
          this.$router.push({path: '/studentManage'})
        }
      })
    },
    cancel() { //取消按钮
      this.form = {}
    },

  }
};
</script>
<style lang="scss" scoped>
.add {
  padding: 0px 40px;
  width: 400px;
}
</style>

