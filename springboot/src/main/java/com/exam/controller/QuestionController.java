package com.exam.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.entity.ApiResult;
import com.exam.serviceimpl.QuestionServiceImpl;
import com.exam.util.ApiResultHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @Author yanwenhui
 * @Date 2019/11/29 15:10
 **/
@RestController
@RequestMapping("/question")
public class QuestionController {

    @Autowired
    QuestionServiceImpl questionService;

    @GetMapping(value = {"", "/"})
    public ApiResult getSubject() {
        return ApiResultHandler.buildApiResult(200, "get question subject", questionService.getSubject());
    }

    @GetMapping(value = "/all/{page}/{size}")
    public ApiResult getAllQuestion(@PathVariable("page") Integer page,
                                    @PathVariable("size") Integer size,
                                    @RequestParam(required = false) String qusetionType,
                                    @RequestParam(required = false) String subject) {
        Page answerVOPage = new Page(page,size);
        return ApiResultHandler.buildApiResult(200, "get all question", questionService.getAllQuestion(answerVOPage, qusetionType, subject));
    }

}
