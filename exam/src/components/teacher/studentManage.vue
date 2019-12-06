// 学生管理页面
<template>
  <div class="all">

    <el-form :model="searchDto">
      <el-row>
        <el-col :span="6">
          <el-form-item label="姓名:">
            <el-input placeholder="学生姓名" size="medium" prefix-icon="el-icon-search" v-model="searchDto.studentName"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="学院:">
            <el-select size="medium" clearable  v-model="searchDto.institute" placeholder="选择学院">
              <el-option v-for="(item, index) in initSearch.institute" :key="index" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="专业:">
            <el-select size="medium" clearable v-model="searchDto.major" placeholder="选择专业">
              <el-option v-for="(item, index) in initSearch.major" :key="index" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="年级:">
            <el-select size="medium" multiple v-model="searchDto.gradeList" placeholder="选择年级">
              <el-option v-for="(item, index) in initSearch.grade" :key="index" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>


    <el-table :data="pagination.records" highlight-current-row>
      <el-table-column fixed="left" prop="studentId" label="学号" width="180"></el-table-column>
      <el-table-column prop="studentName" label="姓名" width="160"></el-table-column>
      <el-table-column prop="institute" label="学院" width="220"></el-table-column>
      <el-table-column prop="major" label="专业" width="200"></el-table-column>
      <el-table-column prop="grade" label="年级" width="150"></el-table-column>
      <el-table-column prop="clazz" label="班级" width="120"></el-table-column>
      <el-table-column prop="sex" label="性别" width="100"></el-table-column>
      <el-table-column prop="tel" label="联系方式" width="180"></el-table-column>
      <el-table-column fixed="right" label="操作" width="180">
        <template slot-scope="scope">
          <el-button @click="checkGrade(scope.row.studentId)" type="primary" size="small">编辑</el-button>
          <el-button @click="deleteById(scope.row.studentId)" type="danger" size="small">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="pagination.current"
      :page-sizes="[6, 10]"
      :page-size="pagination.size"
      layout="total, sizes, prev, pager, next, jumper"
      :total="pagination.total"
      class="page">
    </el-pagination>
    <!-- 编辑对话框-->
    <el-dialog
      title="编辑试卷信息"
      :visible.sync="dialogVisible"
      width="30%"
      :before-close="handleClose">
      <section class="update">
        <el-form ref="form" :model="form" label-width="80px">
          <el-form-item label="姓名">
            <el-input v-model="form.studentName"></el-input>
          </el-form-item>
          <el-form-item label="学院">
            <el-input v-model="form.institute"></el-input>
          </el-form-item>
          <el-form-item label="专业">
            <el-input v-model="form.major"></el-input>
          </el-form-item>
          <el-form-item label="年级">
            <el-input v-model="form.grade"></el-input>
          </el-form-item>
          <el-form-item label="班级">
            <el-input v-model="form.clazz"></el-input>
          </el-form-item>
          <el-form-item label="性别">
            <el-input v-model="form.sex"></el-input>
          </el-form-item>
          <el-form-item label="电话号码">
            <el-input v-model="form.tel"></el-input>
          </el-form-item>
          <el-form-item label="邮箱">
            <el-input v-model="form.email"></el-input>
          </el-form-item>
        </el-form>
      </section>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submit()">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  data() {
    return {
      pagination: {
        //分页后的考试信息
        current: 1, //当前页
        total: null, //记录条数
        size: 6, //每页条数
      },
      dialogVisible: false, //对话框
      form: {}, //保存点击以后当前试卷的信息
      initSearch:{
          institute:[],
          major:[],
          grade:[],
      },
      searchDto:{
        studentName: '',
        institute:'',
        major:'',
        gradeList:[],
      },
    };
  },
  created() {
    this.getStudentType();
    this.getStudentInfo();
  },
  methods: {
    getStudentType() {
      this.$axios({
          url: '/api/student/init',
          method: 'get',
      }).then(res => {
        this.initSearch.institute = res.data.data.institute_list;
        this.initSearch.major = res.data.data.major_list;
        this.initSearch.grade = res.data.data.grade_list;
      }).catch(error => {});
    },
    getStudentInfo() {
      //分页查询所有试卷信息
      this.$axios({
        url: `/api/student/select/${this.pagination.current}/${this.pagination.size}`,
        method: 'post',
        data: {
            ...this.searchDto,
        }
      }).then(res => {
          this.pagination = res.data.data;
      }).catch(error => {});
    },
    //改变当前记录条数
    handleSizeChange(val) {
      this.pagination.size = val;
      this.getStudentInfo();
    },
    //改变当前页码，重新发送请求
    handleCurrentChange(val) {
      this.pagination.current = val;
      this.getStudentInfo();
    },
    checkGrade(studentId) { //修改学生信息
      this.dialogVisible = true
      this.$axios(`/api/student/${studentId}`).then(res => {
        this.form = res.data.data
      })
    },
    deleteById(studentId) { //删除当前学生
      this.$confirm("确定删除当前学生吗？删除后无法恢复","Warning",{
        confirmButtonText: '确定删除',
        cancelButtonText: '算了,留着吧',
        type: 'danger'
      }).then(()=> { //确认删除
        this.$axios({
          url: `/api/student/${studentId}`,
          method: 'delete',
        }).then(res => {
          this.getStudentInfo()
        })
      }).catch(() => {

      })
    },
    submit() { //提交更改
      this.dialogVisible = false
      this.$axios({
        url: '/api/student',
        method: 'put',
        data: {
          ...this.form
        }
      }).then(res => {
        console.log(res)
        if(res.data.code ==200) {
          this.$message({
            message: '更新成功',
            type: 'success'
          })
        }
        this.getStudentInfo()
      })
    },
    handleClose(done) { //关闭提醒
      this.$confirm('确认关闭？')
        .then(_ => {
          done();
        }).catch(_ => {});
    },
  },
  watch: {
      searchDto: {
      deep: true,
      handler: function () {
          this.$axios({
              url: `/api/student/select/1/${this.pagination.size}`,
              method: 'post',
              data: {
                  ...this.searchDto,
              }
          }).then(res => {
              this.pagination = res.data.data;
          }).catch(error => {});
      }
      }
  }
};
</script>
<style lang="scss" scoped>
.all {
  padding: 0px 50px;
  .page {
    margin-top: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .edit {
    margin-left: 20px;
  }
  .el-table tr {
    background-color: #dd5862 !important;
  }
}
.el-form {
  padding: 0px 20px 30px 0px;
}
.el-form .el-input{
  width: 200px;
}
.el-table .warning-row {
  background: #000 !important;
}

.el-table .success-row {
  background: #dd5862;
}
</style>
