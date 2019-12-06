// 添加题库
<template>
  <div class="add">
    <el-tabs v-model="activeName">
    <el-tab-pane name="first">
      <span slot="label"><i class="el-icon-circle-plus"></i>添加试题</span>
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
            <el-col :span="12">
              <el-form-item label="题目类型:">
                <el-select size="medium" clearable v-model="questionType" placeholder="选择题型">
                  <el-option v-for="(item, index) in typeList" :key="index" :label="item" :value="item"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="已有题目总数:">
                <label>{{count}}</label>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>

        <el-table :data="pagination.records" highlight-current-row :row-class-name="tableRowClassName">
          <el-table-column type="index" width="50"></el-table-column>
          <el-table-column prop="question" label="题目信息" width="500"></el-table-column>
          <el-table-column prop="subject" label="所属课程" width="180"></el-table-column>
          <el-table-column prop="type" label="题目类型" width="180"></el-table-column>
          <el-table-column prop="score" label="试题分数" width="150"></el-table-column>
          <el-table-column prop="level" label="难度等级" width="133"></el-table-column>
          <el-table-column prop="collect" label="收藏数量" width="100"></el-table-column>
          <el-table-column prop="collect" label="正确率" width="100"></el-table-column>
          <el-table-column fixed="right" label="操作" width="100">
            <template slot-scope="scope">
              <el-button v-if="scope.row.isInclude" type="danger" size="small" @click="removeQuestion(scope.row.questionId, scope.row.type)">移除</el-button>
              <el-button v-else type="success" size="small" @click="addQuestion(scope.row.questionId, scope.row.type)">添加</el-button>
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
          class="page"
        ></el-pagination>
      </div>
    </el-tab-pane>
    <el-tab-pane name="second">
      <span slot="label"><i class="iconfont icon-daoru-tianchong"></i>一键组卷</span>
      <div class="box">
        <ul>
          <li>
            <span>试题难度:</span>
            <el-select v-model="difficultyValue" placeholder="试题难度" class="w150">
              <el-option
                v-for="item in difficulty"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </li>
          <li>
            <span>选择题数量：</span> <el-input type="text" v-model="changeNumber"></el-input>
          </li>
          <li>
            <span>填空题数量：</span> <el-input type="text" v-model="fillNumber"></el-input>
          </li>
          <li>
            <span>判断题数量：</span> <el-input type="text" v-model="judgeNumber"></el-input>
          </li>
          <li>
            <el-button type="primary" @click="create()">立即组卷</el-button>
          </li>
        </ul>
      </div>
    </el-tab-pane>
  </el-tabs>
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
      subjectList: [],
      typeList: ['选择题', '填空题', '判断题'],
      questionType: '',
      // subject: '',
      changeNumber: null, //选择题出题数量
      fillNumber: null, //填空题出题数量
      judgeNumber: null, //判断题出题数量
      activeName: 'first',  //活动选项卡
      difficulty: [ //试题难度
        {
          value: '简单',
          label: '简单'
        },
        {
          value: '一般',
          label: '一般'
        },
        {
          value: '困难',
          label: '困难'
        }
      ],
      difficultyValue: '简单',

      subject: '', //试卷名称用来接收路由参数

      postPaper: { //考试管理表对应字段
        paperId: null,
        questionType: null, // 试卷类型 1--选择题  2--填空题   3--判断题
        questionId: null,
      },
      count: "50",
    };
  },
  created() {
    this.getParams();
    this.getAnswerInfo();
    this.getsubjectList();
  },
  methods: {
    // handleClick(tab, event) {
    //   console.log(tab, event);
    // },
    getsubjectList() {
        this.$axios('/api/question').then(res => {this.subjectList = res.data.data})
    },
    getAnswerInfo() {
        //分页查询所有试卷信息
        var url = `/api/question/all/${this.pagination.current}/${this.pagination.size}`;
        var param = {paperId: this.postPaper.paperId};
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
        this.getCount(this.postPaper.paperId);
    },
    //改变当前记录条数
    handleSizeChange(val) {
        this.pagination.size = val
        this.getAnswerInfo()
    },
    //改变当前页码，重新发送请求
    handleCurrentChange(val) {
        this.pagination.current = val
        this.getAnswerInfo()
    },
    create() {
      this.$axios({
        url: '/api/item',
        method: 'post',
        data: {
          changeNumber: this.changeNumber,
          fillNumber: this.fillNumber,
          judgeNumber: this.judgeNumber,
          paperId: this.paperId,
          subject: '计算机网络' //题目数量太少，指定为计算机网络出题
        }
      }).then(res => {
        console.log(res)
        let data = res.data
        if(data.code==200){
          setTimeout(() => {
            this.$router.push({path: '/selectAnswer'})
          },1000)
           this.$message({
            message: data.message,
            type: 'success'
          })
        }else if(data.code==400){
            this.$message({
            message: data.message,
            type: 'error'
          })
        }

      })
    },
    getParams() {
      let subject = this.$route.query.subject //获取试卷名称
      let paperId = this.$route.query.paperId //获取paperId
      this.postPaper.paperId = paperId
      this.subject = subject
    },
    addQuestion(questionId, questionType) {
        this.postPaper.questionId = questionId;
        if(questionType === '选择题') {
            this.postPaper.questionType = 1;
        } else if (questionType === '填空题') {
            this.postPaper.questionType = 2;
        } else {
            this.postPaper.questionType = 3;
        }
        this.$axios({
            url: '/api/paperManage',
            method: 'Post',
            data: {
                ...this.postPaper
            }
        }).then(res => {
            if(res.data.code == 200) {
                this.$message({ //成功修改提示
                    message: '更新成功',
                    type: 'success'
                })
            }
            this.getAnswerInfo();
        })
    },
    removeQuestion(questionId, questionType) {
        this.postPaper.questionId = questionId;
        if(questionType === '选择题') {
            this.postPaper.questionType = 1;
        } else if (questionType === '填空题') {
            this.postPaper.questionType = 2;
        } else {
            this.postPaper.questionType = 3;
        }
        this.$axios({
            url: '/api/paperManage',
            method: 'Delete',
            data: {
                ...this.postPaper
            }
        }).then(res => {
            if(res.data.code == 200) {
                this.$message({ //成功修改提示
                    message: '更新成功',
                    type: 'success'
                })
            }
            this.getAnswerInfo();
        })
    },
    getCount(paperId){
        this.$axios({
            url: `/api/type-count/${paperId}`,
            method: 'Get',
        }).then(res => {
            this.count = res.data.data;
        })
    },
    changeSubmit() { //选择题题库提交
      this.postChange.subject = this.subject
      this.$axios({ //提交数据到选择题题库表
        url: '/api/MultiQuestion',
        method: 'post',
        data: {
          ...this.postChange
        }
      }).then(res => { //添加成功显示提示
        let status = res.data.code
        if(status == 200) {
          this.$message({
            message: '已添加到题库',
            type: 'success'
          })
          this.postChange = {}
        }
      }).then(() => {
        this.$axios(`/api/multiQuestionId`).then(res => { //获取当前题目的questionId
          let questionId = res.data.data.questionId
          this.postPaper.questionId = questionId
          this.postPaper.questionType = 1
          this.$axios({
            url: '/api/paperManage',
            method: 'Post',
            data: {
              ...this.postPaper
            }
          })
        })
      })
    },
    fillSubmit() { //填空题提交
      this.postFill.subject = this.subject
      this.$axios({
        url: '/api/fillQuestion',
        method: 'post',
        data: {
          ...this.postFill
        }
      }).then(res => {
        let status = res.data.code
        if(status == 200) {
          this.$message({
            message: '已添加到题库',
            type: 'success'
          })
          this.postFill = {}
        }
      }).then(() => {
        this.$axios(`/api/fillQuestionId`).then(res => { //获取当前题目的questionId
          let questionId = res.data.data.questionId
          this.postPaper.questionId = questionId
          this.postPaper.questionType = 2
          this.$axios({
            url: '/api/paperManage',
            method: 'Post',
            data: {
              ...this.postPaper
            }
          })
        })
      })
    },
    judgeSubmit() { //判断题提交
      this.postJudge.subject = this.subject
      this.$axios({
        url: '/api/judgeQuestion',
        method: 'post',
        data: {
          ...this.postJudge
        }
      }).then(res => {
        let status = res.data.code
        if(status == 200) {
          this.$message({
            message: '已添加到题库',
            type: 'success'
          })
          this.postJudge = {}
        }
      }).then(() => {
        this.$axios(`/api/judgeQuestionId`).then(res => { //获取当前题目的questionId
          let questionId = res.data.data.questionId
          this.postPaper.questionId = questionId
          this.postPaper.questionType = 3
          this.$axios({
            url: '/api/paperManage',
            method: 'Post',
            data: {
              ...this.postPaper
            }
          })
        })
      })
    }
  },watch: {
    questionType: {
        deep: true,
            handler: function () {
            var url = `/api/question/all/1/${this.pagination.size}`;
            var param = {paperId: this.postPaper.paperId};
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
            this.getCount(this.postPaper.paperId);
        }
    }, subject: {
        deep: true,
            handler: function () {
            var url = `/api/question/all/1/${this.pagination.size}`;
            var param = {paperId: this.postPaper.paperId};
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
            this.getCount(this.postPaper.paperId);
        }
    }
}
};
</script>

<style lang="scss" scoped>
.add {
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
  margin: 0px 40px;
  .box {
    padding: 0px 20px;
    ul li {
      margin: 10px 0px;
      display: flex;
      align-items: center;
      .el-input {
        width: 6%;
      }
      .w150 {
        margin-left: 20px;
        width: 7%;
      }
    }
  }
  .el-icon-circle-plus {
    margin-right: 10px;
  }
  .icon-daoru-tianchong {
    margin-right: 10px;
  }
  .append {
    margin: 0px 20px;
    ul {
      display: flex;
      align-items: center;
      li {
        margin-right: 20px;
      }
    }
    .change {
      margin-top: 20px;
      padding: 20px 16px;
      background-color: #E7F6F6;
      border-radius: 4px;
      .title {
        padding-left: 6px;
        color: #2f4f4f;
        span:nth-child(1) {
          margin-right: 6px;
        }
        .answer {
          margin: 20px 0px 20px 8px;
        }
        .el-textarea {
          width: 98% !important;
        }
      }
      .options {
        ul {
          display: flex;
          flex-direction: column;
        }
        ul li {
          display: flex;
          justify-content: center;
          align-items: center;
          width: 98%;
          margin: 10px 0px;
          span {
            margin-right: 20px;
          }
        }
      }
      .submit {
        display: flex;
        justify-content: center;
        align-items: center;
      }
    }
    .fill {
      .fillAnswer {
        display: flex;
        justify-content: center;
        align-items: center;
        span {
          margin-right: 6px;
        }
        .el-input {
          width: 91% !important;
        }
      }
      .analysis {
        margin-top: 20px;
        margin-left: 5px;
      }
    }
    .judge {
      .judgeAnswer {
        margin-left: 20px;
        margin-bottom: 20px;
      }
    }
    .w150 {
      width: 150px;
    }
    li:nth-child(2) {
      display: flex;
      align-items: center;
      justify-content: center;
    }
  }
}
</style>


