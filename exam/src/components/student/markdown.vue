<template>
  <div id="main">
    <el-form :inline="true" :model="note" class="demo-form-inline" size="small" style="height: 100%">
      <el-form-item label="标题:">
        <el-input v-model="note.title" placeholder="标题" style="width: 300px"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="info" @click="toWriteNote">返回</el-button>
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
                    noteId: null,
                    studentId: null,
                    title: '',
                    content: ''
                }
            }
        },
        created() {
            this.getNode();
        },
        methods: {
            getNode() {
                this.note = this.$route.query.thisNote;
            },
            onSubmit() {
                console.log(this.note);
                this.$axios.post(`/api/note`, {
                    'noteId': this.note.noteId,
                    'studentId': this.note.studentId,
                    'title': this.note.title,
                    'content': this.note.content,
                }).then( () => {
                    this.$message.success('保存成功');
                    this.toWriteNote();
                }).catch( () => {
                    this.$message.error('标题已存在，保存失败');
                })
            },
            toWriteNote() {
                this.$router.push({path:'/writeNote'});
            },
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
