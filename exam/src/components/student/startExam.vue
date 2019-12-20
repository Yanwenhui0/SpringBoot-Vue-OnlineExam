// 我的考试页面
<template>
  <div id="myExam">
    <div class="title">我的练习</div>
    <div class="wrapper">
      <ul class="top">
        <li>
          <el-button type="success" plain @click="dialogVisible = true">创建练习</el-button>
        </li>
        <li class="search-li">
          <div class="icon"><input type="text" placeholder="练习名称" class="search" v-model="key"><i
            class="el-icon-search"></i></div>
        </li>
        <li>
          <el-button type="primary" @click="search()">搜索练习</el-button>
        </li>
      </ul>
      <ul class="paper" v-loading="loading">
        <li class="item" @click="toExamMsg(item.exerciseId)" v-for="(item,index) in pagination.records" :key="index">
          <h4>{{item.name}}</h4>
          <p class="name">学科：{{item.subject}}</p>
          <p class="name">备注：{{item.remark}}</p>
          <div class="info">
            <i class="iconfont icon-icon-time"></i><span>{{item.created.substr(0,10)}}</span>
<!--            <i class="iconfont icon-icon-time"></i><span v-if="item.totalTime != null">限时{{item.totalTime}}分钟</span>-->
            <i class="iconfont icon-fenshu"></i><span>满分{{item.total}}分</span>
          </div>
        </li>
      </ul>
      <div class="pagination">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pagination.current"
          :page-sizes="[6, 10]"
          :page-size="pagination.size"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pagination.total">
        </el-pagination>
      </div>
    </div>


    <el-dialog
      title="添加练习"
      :visible.sync="dialogVisible"
      width="30%"
      :before-close="handleClose">
      <section class="update">
        <el-form ref="form" :model="form" label-width="80px">
          <el-form-item label="练习名称" prop="name">
            <el-input v-model="form.name"></el-input>
          </el-form-item>
          <el-form-item label="课程" prop="subject">
            <el-select size="medium" clearable v-model="form.subject" placeholder="选择课程">
              <el-option v-for="(item, index) in subjectList" :key="index" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="备注" prop="remark">
            <el-input v-model="form.remark"></el-input>
          </el-form-item>
          <el-form-item label="选择题" prop="multiNumber">
            <el-input v-model="form.multiNumber">
              <template slot="append">个</template>
            </el-input>
          </el-form-item>
          <el-form-item label="填空题" prop="fillNumber">
            <el-input v-model="form.fillNumber">
              <template slot="append">个</template>
            </el-input>
          </el-form-item>
          <el-form-item label="判断题" prop="judgeNumber">
            <el-input v-model="form.judgeNumber">
              <template slot="append">个</template>
            </el-input>
          </el-form-item>
        </el-form>
      </section>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false" size="small">取 消</el-button>
        <el-button type="primary" @click="submit()" size="small">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
    export default {
        // name: 'myExam'
        data() {
            return {
                dialogVisible: false,
                loading: false,
                key: null, //搜索关键字
                allExam: null, //所有考试信息
                pagination: { //分页后的考试信息
                    current: 1, //当前页
                    total: null, //记录条数
                    size: 6 //每页条数
                },
                subjectList: [],
                form: {
                    studentId: '',
                    subject: '',
                    name: '',
                    remark: '',
                    multiNumber: '',
                    fillNumber: '',
                    judgeNumber: ''
                }
            }
        },
        created() {
            this.loading = true;
            this.form.studentId = this.$cookies.get('cid')
            this.getsubjectList();
            this.getExerciseInfo();
        },
        // watch: {
        //     dialogVisible: {
        //         deep: true,
        //         handler: function () {
        //             if(this.dialogVisible == false) {
        //                 this.$refs.form.resetFields()
        //             }
        //         }
        //    }
        // },
        methods: {
            submit() {
                this.$axios({
                    url: '/api/exercise',
                    method: 'post',
                    data: this.form,
                }).then(res => {
                    if(res.data.code == 200){
                        this.dialogVisible = false
                        this.$refs.form.resetFields()
                        this.$message.success(res.data.message)
                        this.getExerciseInfo()
                    } else {
                        this.$message.error(res.data.message)
                    }
                })
            },
            handleClose(done) {
                this.$confirm('确认关闭？')
                    .then(_ => {
                        this.$refs.form.resetFields()
                        done();
                    })
                    .catch(_ => {
                    });
            },
            getsubjectList() {
                this.$axios('/api/question').then(res => {
                    this.subjectList = res.data.data
                })
            },
            //获取当前所有考试信息
            getExerciseInfo() {
                this.$axios(`/api/exercise/all/${this.pagination.current}/${this.pagination.size}`).then(res => {
                    this.pagination = res.data.data
                    this.loading = false
                    console.log(this.pagination)
                }).catch(error => {
                    console.log(error)
                })
            },
            //改变当前记录条数
            handleSizeChange(val) {
                this.pagination.size = val
                this.getExamInfo()
            },
            //改变当前页码，重新发送请求
            handleCurrentChange(val) {
                this.pagination.current = val
                this.getExamInfo()
            },
            //搜索试卷
            search() {
                this.$axios('/api/exams').then(res => {
                    if (res.data.code == 200) {
                        let allExam = res.data.data
                        let newPage = allExam.filter(item => {
                            return item.source.includes(this.key)
                        })
                        this.pagination.records = newPage
                    }
                })
            },
            //跳转到试卷详情页
            toExamMsg(examCode) {
                this.$router.push({path: '/answer', query: {examCode: examCode}})
                console.log(examCode)
            }
        }
    }
</script>


<style lang="scss" scoped>
  .pagination {
    padding: 20px 0px 30px 0px;

    .el-pagination {
      display: flex;
      justify-content: center;
    }
  }

  .paper {
    h4 {
      cursor: pointer;
    }
  }

  .paper .item a {
    color: #000;
  }

  .wrapper .top .order {
    cursor: pointer;
  }

  .wrapper .top .order:hover {
    color: #0195ff;
    border-bottom: 2px solid #0195ff;
  }

  .wrapper .top .order:visited {
    color: #0195ff;
    border-bottom: 2px solid #0195ff;
  }

  .item .info i {
    margin-right: 5px;
    color: #0195ff;
  }

  .item .info span {
    margin-right: 14px;
  }

  .paper .item {
    width: 380px;
    border-radius: 4px;
    padding: 20px 30px;
    border: 1px solid #eee;
    box-shadow: 0 0 4px 2px rgba(217, 222, 234, 0.3);
    transition: all 0.6s ease;
    cursor: pointer;
  }

  .paper .item:hover {
    box-shadow: 0 0 4px 2px rgba(140, 193, 248, 0.45);
    transform: scale(1.03);
  }

  .paper .item .info {
    font-size: 14px;
    color: #88949b;
  }

  .paper .item .name {
    font-size: 14px;
    color: #88949b;
  }

  .paper * {
    margin: 20px 0;
  }

  .wrapper .paper {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
  }

  .top .el-icon-search {
    position: absolute;
    right: 10px;
    top: 10px;
  }

  .top .icon {
    position: relative;
  }

  .wrapper .top {
    border-bottom: 1px solid #eee;
    margin-bottom: 20px;
  }

  #myExam .search-li {
    margin-left: auto;
  }

  .top .search-li {
    margin-left: auto;
  }

  .top li {
    display: flex;
    align-items: center;
  }

  .top .search {
    margin-left: auto;
    padding: 10px;
    border-radius: 4px;
    border: 1px solid #eee;
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  }

  .top .search:hover {
    color: #0195ff;
    border-color: #0195ff;
  }

  .wrapper .top {
    display: flex;
  }

  .wrapper .top li {
    margin: 20px;
  }

  #myExam {
    width: 980px;
    margin: 0 auto;
  }

  #myExam .title {
    margin: 20px;
  }

  #myExam .wrapper {
    background-color: #fff;
  }

  .wrapper .top .order {
    cursor: pointer;
  }

  .wrapper .top .order:hover {
    color: #0195ff;
    border-bottom: 2px solid #0195ff;
  }

  .wrapper .top .order:visited {
    color: #0195ff;
    border-bottom: 2px solid #0195ff;
  }

  .item .info i {
    margin-right: 5px;
    color: #0195ff;
  }

  .item .info span {
    margin-right: 14px;
  }

  .paper .item {
    border-radius: 4px;
    padding: 20px 30px;
    border: 1px solid #eee;
    box-shadow: 0 0 4px 2px rgba(217, 222, 234, 0.3);
    transition: all 0.6s ease;
  }

  .paper .item:hover {
    box-shadow: 0 0 4px 2px rgba(140, 193, 248, 0.45)
  }

  .paper .item .info {
    font-size: 14px;
    color: #88949b;
  }

  .paper .item .name {
    font-size: 14px;
    color: #88949b;
  }

  .paper * {
    margin: 20px 0;
  }

  .wrapper .paper {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
  }

  .top .el-icon-search {
    position: absolute;
    right: 10px;
    top: 10px;
  }

  .top .icon {
    position: relative;
  }

  .wrapper .top {
    border-bottom: 1px solid #eee;
  }

  #myExam .search-li {
    margin-left: auto;
  }

  .top .search-li {
    margin-left: auto;
  }

  .top li {
    display: flex;
    align-items: center;
  }

  .top .search {
    margin-left: auto;
    padding: 10px;
    border-radius: 4px;
    border: 1px solid #eee;
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  }

  .top .search:hover {
    color: #0195ff;
    border-color: #0195ff;
  }

  .wrapper .top {
    display: flex;
  }

  .wrapper .top li {
    margin: 20px;
  }

  #myExam {
    width: 980px;
    margin: 0 auto;
  }

  #myExam .title {
    margin: 20px;
  }

  #myExam .wrapper {
    background-color: #fff;
  }
</style>
