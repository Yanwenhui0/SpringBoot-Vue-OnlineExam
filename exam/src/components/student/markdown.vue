<template>
  <div id="main">
    <el-form :inline="true" :model="note" class="demo-form-inline" size="mini" style="height: 100%">
      <el-form-item label="标题:">
        <el-input v-model="note.title" placeholder="标题"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="onSubmit">保存</el-button>
      </el-form-item>
      <mavon-editor v-model="note.content" style="height: 100%"/>
    </el-form>
  </div>
</template>

<script>
    export default {
        name: "markdown",
        data() {
            return {
                note: {
                    title: null,
                    content: null
                }
            }
        },
        created() {
            this.getNode();
        },
        methods: {
            getNode() {
                let id = this.$route.params.markdownId;
            }
        }
    }
</script>

<style scoped>
  #main {
    width: 980px;
    margin: 50px auto;
    height: 680px;
  }
</style>
