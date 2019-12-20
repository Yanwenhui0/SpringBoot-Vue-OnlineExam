package com.exam.controller;

import com.exam.entity.ApiResult;
import com.exam.entity.Exercise;
import com.exam.service.ExerciseService;
import com.exam.serviceimpl.FillQuestionServiceImpl;
import com.exam.serviceimpl.JudgeQuestionServiceImpl;
import com.exam.serviceimpl.MultiQuestionServiceImpl;
import com.exam.util.ApiResultHandler;
import com.exam.vo.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author yanwenhui
 * @Date 2019/12/10 10:29
 **/
@RestController
@RequestMapping("/exercise")
public class ExerciseController {

    @Autowired
    MultiQuestionServiceImpl multiQuestionService;

    @Autowired
    FillQuestionServiceImpl fillQuestionService;

    @Autowired
    JudgeQuestionServiceImpl judgeQuestionService;

    @Autowired
    ExerciseService exerciseService;

    @GetMapping(value = "/all/{page}/{limit}")
    public ApiResult getAll(@PathVariable int page, @PathVariable int limit) {
        return ApiResultHandler.buildApiResult(200,"查询成功",exerciseService.getAll(page, limit));
    }

    @GetMapping(value = "/{exerciseId}")
    public ApiResult getOne(@PathVariable int exerciseId) {
        return ApiResultHandler.buildApiResult(200,"查询成功",exerciseService.getOne(exerciseId));
    }

    @PostMapping(value = {"", "/"})
    public ApiResult save(@RequestBody Exercise exercise) {
        // 选择题
        Integer multiNumber = exercise.getMultiNumber();
        // 填空题
        Integer fillNumber = exercise.getFillNumber();
        // 判断题
        Integer judgeNumber = exercise.getJudgeNumber();

        // 选择题数据库获取
        List<Integer> multis = multiQuestionService.findBySubject(exercise.getSubject(), multiNumber);
        if(multis==null)
            return ApiResultHandler.buildApiResult(400,"选择题数据库获取失败",null);
        // 填空题
        List<Integer> fills = fillQuestionService.findBySubject(exercise.getSubject(), fillNumber);
        if(fills==null)
            return ApiResultHandler.buildApiResult(400,"填空题数据库获取失败",null);
        // 判断题
        List<Integer> judges = judgeQuestionService.findBySubject(exercise.getSubject(), judgeNumber);
        if(fills==null)
            return ApiResultHandler.buildApiResult(400,"判断题数据库获取失败",null);

        exercise.setMulti(String.join(",", multis.stream().map(String::valueOf).collect(Collectors.toList())));
        exercise.setFill(String.join(",", fills.stream().map(String::valueOf).collect(Collectors.toList())));
        exercise.setJudge(String.join(",", judges.stream().map(String::valueOf).collect(Collectors.toList())));
        exercise.setTotal(2 * (multiNumber + fillNumber + judgeNumber));
        exercise.setCreated(new Date());

        if(1 == exerciseService.save(exercise))
            return ApiResultHandler.buildApiResult(200,"组装练习成功",null);
        else
            return ApiResultHandler.buildApiResult(400,"组装练习失败",null);
    }

    @DeleteMapping(value = "/{exerciseId}")
    public ApiResult save(@PathVariable int exerciseId) {
        if(1 == exerciseService.delete(exerciseId))
            return ApiResultHandler.buildApiResult(200,"删除练习成功",null);
        else
            return ApiResultHandler.buildApiResult(400,"删除练习失败",null);
    }

}
