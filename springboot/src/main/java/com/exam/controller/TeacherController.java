package com.exam.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.Dto.TeacherSearchDto;
import com.exam.entity.ApiResult;
import com.exam.entity.Teacher;
import com.exam.service.TeacherService;
import com.exam.serviceimpl.TeacherServiceImpl;
import com.exam.util.ApiResultHandler;
import com.exam.vo.AnswerVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class TeacherController {

    private TeacherService teacherService;
    @Autowired
    public TeacherController(TeacherService teacherService){
        this.teacherService = teacherService;
    }

    @GetMapping("/teacher/init")
    public ApiResult initSelect() {
        return ApiResultHandler.buildApiResult(200,"查询学生分类",teacherService.initSelect());
    }

    @PostMapping("/teachers/{page}/{size}")
    public ApiResult findAll(@RequestBody TeacherSearchDto teacherSearchDto,
                             @PathVariable Integer page,
                             @PathVariable Integer size){
        return ApiResultHandler.buildApiResult(200,"查询所有教师",teacherService.selectByEntity(teacherSearchDto, new Page<>(page,size)));
    }

    @GetMapping("/teacher/{teacherId}")
    public ApiResult findById(@PathVariable("teacherId") Integer teacherId){
        return ApiResultHandler.success(teacherService.findById(teacherId));
    }

    @DeleteMapping("/teacher/{teacherId}")
    public ApiResult deleteById(@PathVariable("teacherId") Integer teacherId){
        return ApiResultHandler.success(teacherService.deleteById(teacherId));
    }

    @PutMapping("/teacher")
    public ApiResult update(@RequestBody Teacher teacher){
        return ApiResultHandler.success(teacherService.update(teacher));
    }

    @PostMapping("/teacher")
    public ApiResult add(@RequestBody Teacher teacher){
        return ApiResultHandler.success(teacherService.add(teacher));
    }
}
