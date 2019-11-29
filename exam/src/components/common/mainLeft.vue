<!--左边下拉导航栏-->
<template>
  <div id="left">
    <el-menu
      active-text-color="#dd5862"
      text-color="#000"
      :default-active="this.$route.path"
      class="el-menu-vertical-demo"
      @open="handleOpen"
      @close="handleClose"
      :collapse="flag"
      background-color="#6e869d"
      menu-trigger="click" router>
      <el-submenu v-for="(item,index) in menu" :index='item.index' :key="index">
        <template slot="title">
          <div class="left-width">
            <i class="iconfont" :class="item.icon"></i>
            <span slot="title" class="title">{{item.title}}</span>
          </div>
        </template>
          <el-menu-item v-for="(list,index1) in item.content" :key="index1" @click="handleTitle(item.index)" :index="list.path">{{list.item}}</el-menu-item>
      </el-submenu>
    </el-menu>
    <i class="el-icon-notebook-1"></i>
  </div>
</template>

<script>
import store from '@/vuex/store'
import {mapState} from 'vuex'
export default {
  name: "mainLeft",
  data() {
    return {

    }
  },
  computed: mapState(["flag","menu"]),
  created() {
    this.addData()
  },
  methods: {
    handleOpen(key, keyPath) {
      // console.log(key, keyPath);
    },
    handleClose(key, keyPath) {
      // console.log(key, keyPath);
    },
    //点击标题传递参数给navigator组件
    handleTitle(index) {
      this.bus.$emit('sendIndex',index)
    },
    addData() {
      let role = this.$cookies.get("role")
      if(role == 0) {
        this.menu.push({
          index: '5',
          title: '教师管理',
          icon: 'icon-Userselect',
          content:[{item:'教师管理',path:'/teacherManage'},{item: '添加教师',path: '/addTeacher'}],
        })
      }
    }
  },
  store
}
</script>

<style>
.el-menu-vertical-demo .el-submenu__title {
  overflow: hidden;
}
.left-width .iconfont {
  font-size: 18px;
  color: #fff;
}
.left-width {
  width: 200px;
}
.el-menu-vertical-demo:not(.el-menu--collapse) {
  min-height: 900px;
}
#left {
  height: 900px;
  background-color: #6e869d;
  z-index: 0;
}
#left .el-menu-vertical-demo .title {
  color: #fff;
  font-size: 16px;
  font-weight: bold;
  margin-left: 14px;
}
.el-submenu {
  border-bottom: 1px solid rgba(238, 238, 238, 0.16) !important;
}
.el-submenu__title:hover {
  background-color: #fff;
}
.el-submenu__title i {
    color: #fbfbfc !important;
}
.el-menu{

}
.el-menu-item {
  padding-left: 75px !important;
  color: white !important;
}
.el-menu-item.is-active {
  color: #fff !important;
  background: rgba(0, 0, 0, 0.3) !important;
}
.el-icon-notebook-1{
  font-size: 110px;
  color: #b5daf2;
  position: absolute;
  bottom: 40px;
  left: 70px;
}
</style>
