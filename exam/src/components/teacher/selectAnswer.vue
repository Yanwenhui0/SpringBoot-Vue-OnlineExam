//查询所有题库
<template>
  <div class="exam">

    <el-form>
      <el-row>
        <el-col :span="6">
          <el-form-item label="所属课程:">
            <el-select size="medium" clearable v-model="subject" placeholder="选择课程">
              <el-option v-for="(item, index) in subjectList" :key="index" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="题目类型:">
            <el-select size="medium" clearable v-model="questionType" placeholder="选择题型">
              <el-option v-for="(item, index) in typeList" :key="index" :label="item" :value="item"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>

    <el-table :data="pagination.records" highlight-current-row :row-class-name="tableRowClassName">
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="question" label="题目信息" width="600"></el-table-column>
      <el-table-column prop="subject" label="所属课程" width="280"></el-table-column>
      <el-table-column prop="type" label="题目类型" width="200"></el-table-column>
      <el-table-column prop="score" label="试题分数" width="150"></el-table-column>
      <el-table-column prop="level" label="难度等级" width="133"></el-table-column>
      <el-table-column prop="collect" label="收藏数量" width="100"></el-table-column>
    </el-table>
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="pagination.current"
      :page-sizes="[6, 10]"
      :page-size="pagination.size"
      layout="total, sizes, prev, pager, next, jumper"
      :total="pagination.total"
      class="page"
    ></el-pagination>
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
        size: 6 //每页条数
      },
      subjectList: [],
      typeList: ['选择题', '填空题', '判断题'],
      questionType: '',
      subject: '',
    };
  },
  created() {
    this.getAnswerInfo();
    this.getsubjectList();
  },
  methods: {
      getsubjectList() {
          this.$axios('/api/question').then(res => {this.subjectList = res.data.data})
      },
    getAnswerInfo() {
      //分页查询所有试卷信息
      var url = `/api/question/all/${this.pagination.current}/${this.pagination.size}`;
      var param = {};
      if(this.questionType !== '') {
        param.questionType = this.questionType
      }
      if(this.subject !== '') {
        param.subject = this.subject
      }
      this.$axios({
        url: url,
        params: param
    }).then(res => {
          this.pagination = res.data.data;
          console.log(res);
        }).catch(error => {});
    },
    //改变当前记录条数
    handleSizeChange(val) {
      this.pagination.size = val;
      this.getAnswerInfo();
    },
    //改变当前页码，重新发送请求
    handleCurrentChange(val) {
      this.pagination.current = val;
      this.getAnswerInfo();
    },
    tableRowClassName({ row, rowIndex }) {
      if (rowIndex % 2 == 0) {
        return "warning-row";
      } else {
        return "success-row";
      }
    }
  },watch: {
        questionType: {
            deep: true,
            handler: function () {
              var url = `/api/question/all/1/${this.pagination.size}`;
              var param = {};
              if(this.questionType !== '') {
                param.questionType = this.questionType
              }
              if(this.subject !== '') {
                param.subject = this.subject
              }
                this.$axios({
                    url: url,
                    params: param
                }).then(res => {
                        this.pagination = res.data.data;
                        console.log(res);
                    }).catch(error => {});
            }
        }, subject: {
            deep: true,
            handler: function () {
                var url = `/api/question/all/1/${this.pagination.size}`;
                var param = {};
                if(this.questionType !== '') {
                  param.questionType = this.questionType
                }
                if(this.subject !== '') {
                  param.subject = this.subject
                }
                this.$axios({
                    url: url,
                    params: param
                }).then(res => {
                    this.pagination = res.data.data;
                    console.log(res);
                }).catch(error => {});
            }
        }
    }
};
</script>
<style lang="scss" scoped>
.exam {
  padding: 0px 40px;
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
    background-color: #DD5862 !important;
  }
}
  .el-table .warning-row {
    background: #000 !important;

  }

  .el-table .success-row {
    background: #DD5862;
  }

</style>
