<template>
  <div id="main">
    <el-card v-loading="loading">
      <div slot="header">
        <span>我的笔记</span>
        <el-button style="float: right; padding: 3px 10px" type="success" plain @click="toMarkdown(undefined)">写笔记</el-button>
      </div>
      <div v-if="pagination.records" v-for="(item, index) in pagination.records" :key="index">
        <el-card shadow="hover" class="item" @click.native="toMarkdown(item)" >
          <el-row>
            <el-col :span="11" class="el-icon-tickets" style="color: #6ed779;font-size: 20px;font-weight: 200;margin-top: 3px"><h4 class="title"> {{item.title.length > 18 ? item.title.toString().slice(0, 18) + '……' : item.title}}</h4></el-col>
            <el-col :span="6" style="margin-top: 5px !important;">
              <el-tag size="small">创建时间：{{$moment(item.createTime).format('YYYY-MM-DD HH:mm:ss')}}</el-tag>
            </el-col>
            <el-col :span="6" style="margin-top: 5px !important;">
              <el-tag size="small">修改时间：{{$moment(item.updateTime).format('YYYY-MM-DD HH:mm:ss')}}</el-tag>
            </el-col>
            <el-col :span="1">
              <el-button type="danger" icon="el-icon-delete" circle class="deleteB" size="small"
                         @click="deleteQuestion(item.packageId)"></el-button>
            </el-col>
          </el-row>
        </el-card>
      </div>

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
    </el-card>
  </div>
</template>

<script>

export default {
  name: 'writeNote',
  data() {
    return {
        loading: false,
        pagination: { //分页后的考试信息
            current: 1, //当前页
            total: null, //记录条数
            size: 6 //每页条数
        }
    }
  },
  created() {
      this.getMyNote();
      this.loading = true
  },
  methods: {
      getMyNote() {
          let studentId = this.$cookies.get("cid");
          this.$axios(`/api/note/${studentId}/${this.pagination.current}/${this.pagination.size}`).then(res => {
              this.pagination = res.data.data;
              console.log(this.pagination)
          }).catch(error => {
              console.log(error)
          }).finally(() => {
              this.loading = false;
          })
      },
      toMarkdown(val) {
          if(val === undefined) {
              val = {
                  noteId: null,
                  studentId: this.$cookies.get("cid"),
                  title: '',
                  content: ''
              }
          }
          this.$router.push({path:'/markdown', query: {
              'thisNote': val
          }})
      },
      //改变当前记录条数
      handleSizeChange(val) {
          this.pagination.size = val;
          this.getMyPackage()
      },
      //改变当前页码，重新发送请求
      handleCurrentChange(val) {
          this.pagination.current = val;
          this.getMyPackage()
      }
  }
}
</script>

<style lang="scss" scoped>
#main {
  width: 980px;
  margin: 50px auto;
}
.item {
  cursor: pointer;
  margin: 0px 15px 20px 15px;
}
.title {
  font-family: "Helvetica Neue",Helvetica,"PingFang SC","Hiragino Sans GB","Microsoft YaHei","微软雅黑",Arial,sans-serif;
  font-size: 18px;
  color: #303133;
  margin-top: 3px;
  padding-left: 8px;
  display: inline-block;
}
.deleteB {
  display: inline-block;
  vertical-align: bottom;
}
.pagination {
  padding: 20px 0px 30px 0px;

  .el-pagination {
    display: flex;
    justify-content: center;
  }
}

</style>
