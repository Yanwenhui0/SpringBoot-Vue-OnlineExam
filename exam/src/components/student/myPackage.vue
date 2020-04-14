// 我的题目收藏
<template>
  <div id="myExam">
    <div class="title">收藏集</div>
    <div class="wrapper">
      <ul class="paper" v-loading="loading">
        <li class="item" v-for="(item,index) in pagination.records" @click="" :key="index">
          <el-row type="flex" style="margin: 0px !important;">
            <el-col :span="23" style="margin: 0px !important;">
              <h4>{{item.questionType}}</h4>
              <p class="name">题目：{{item.questionBody}}</p>
              <div v-if="item.questionChoose">
                <p class="name">选项：</p>
                <p v-for="(choose, index2) in item.questionChoose" :key="index2" class="choose">{{choose}}</p>
              </div>
              <p class="name">答案：<span class="right">{{item.questionAnswer}}</span></p>
            </el-col>
            <el-col :span="1">
              <el-button type="danger" icon="el-icon-delete" circle class="deleteB"
                         @click="deleteQuestion(item.packageId)"></el-button>
            </el-col>
          </el-row>
        </li>
      </ul>
      <div class="pagination">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pagination.current"
          :page-sizes="[6, 10, 20, 40]"
          :page-size="pagination.size"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pagination.total">
        </el-pagination>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    // name: 'myExam'
    data() {
      return {
        loading: false,
        key: null, //搜索关键字
        allQuesion: null, //所有考试信息
        pagination: { //分页后的考试信息
          current: 1, //当前页
          total: null, //记录条数
          size: 6 //每页条数
        }
      }
    },
    created() {
      this.getMyPackage();
      this.loading = true
    },
    // watch: {

    // },
    methods: {
      deleteQuestion(packageId) {
        this.$axios.delete(`/api/package`, {
          data: {
            'packageId': packageId
          }
        }).then(res => {
          this.$message.success(`删除 (ID:${packageId}) 成功`);
          this.getMyPackage();
        }).catch(() => {
          this.$message.success(`删除失败`);
        })
      },
      getMyPackage() {
        let studentId = this.$cookies.get("cid");
        this.$axios(`/api/package/${studentId}/${this.pagination.current}/${this.pagination.size}`).then(res => {
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
        this.getMyPackage()
      },
      //改变当前页码，重新发送请求
      handleCurrentChange(val) {
        this.pagination.current = val
        this.getMyPackage()
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
    padding-top: 10px;
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

  .paper .item {
    background-color: rgba(168, 177, 245, 0.1);
    width: 822px;
    border-radius: 4px;
    padding: 10px 30px;
    border: 1px solid #eee;
    box-shadow: 0 0 4px 2px rgba(217, 222, 234, 0.3);
    transition: all 0.6s ease;
    cursor: pointer;
  }

  .paper .item:hover {
    box-shadow: 0 0 4px 2px rgba(137, 190, 245, 0.51);
    transform: scale(1.05)
  }

  .paper .item .info {
    font-size: 14px;
    color: #88949b;
  }

  .paper .item .name {
    font-size: 14px;
    color: #88949b;
  }

  .item .name .right {
    color: #2776df;
    font-size: 18px;
    border: 1px solid #2776df;
    padding: 0px 6px;
    border-radius: 5px;
    margin-left: 20px;
  }

  .paper .item .choose {
    padding-left: 30px;
    font-size: 14px;
    color: #88949b;
  }

  .paper .item .deleteB {
    display: inline-block;
    vertical-align: bottom;
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
</style>
