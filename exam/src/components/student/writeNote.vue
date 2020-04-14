<template>
  <div id="main">
    <el-card>
      <div slot="header">
        <span>我的笔记</span>
        <el-button style="float: right; padding: 3px 10px" type="success" plain @click="toMarkdown">写笔记</el-button>
      </div>
      <div v-for="o in 4" :key="o">
        <el-card shadow="hover" class="item">
        {{'列表内容 ' + o }}
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
        pagination: { //分页后的考试信息
            current: 1, //当前页
            total: null, //记录条数
            size: 6 //每页条数
        }
    }
  },
  methods: {
      toMarkdown() {
          this.$router.push({path:'/markdown',query: {
              'markdownId': 'id'
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
  margin: 0px 15px 20px 15px;
}
.pagination {
  padding: 20px 0px 30px 0px;

  .el-pagination {
    display: flex;
    justify-content: center;
  }
}

</style>
