package com.exam.serviceimpl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.entity.FillQuestion;
import com.exam.entity.JudgeQuestion;
import com.exam.entity.MultiQuestion;
import com.exam.entity.PaperManage;
import com.exam.mapper.*;
import com.exam.service.FillQuestionService;
import com.exam.service.JudgeQuestionService;
import com.exam.service.MultiQuestionService;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @Author yanwenhui
 * @Date 2019/11/29 15:13
 **/
@Service
public class QuestionServiceImpl {

    @Autowired
    PaperMapper paperMapper;

    @Autowired
    FillQuestionMapper fillQuestionMapper;

    @Autowired
    JudgeQuestionMapper judgeQuestionMapper;

    @Autowired
    MultiQuestionMapper multiQuestionMapper;

    @Autowired
    AnswerMapper answerMapper;

    public HashSet<String> getSubject() {
        List<String> subjects = fillQuestionMapper.selectList(null).stream().map(FillQuestion::getSubject).collect(Collectors.toList());
        subjects.addAll(judgeQuestionMapper.selectList(null).stream().map(JudgeQuestion::getSubject).collect(Collectors.toList()));
        subjects.addAll(multiQuestionMapper.selectList(null).stream().map(MultiQuestion::getSubject).collect(Collectors.toList()));
        return Sets.newHashSet(subjects.stream().filter(StringUtils::isNotBlank).collect(Collectors.toList()));
    }

    public IPage getAllQuestion(Page page, String questionType, String subject, String paperId) {
        IPage result = null;
        if (StringUtils.isNotBlank(questionType)) {
            switch (questionType) {
                case "选择题":
                    if (StringUtils.isNotBlank(subject)) {
                        MultiQuestion multiQuestion = new MultiQuestion();
                        multiQuestion.setSubject(subject);
                        result = multiQuestionMapper.selectPage(page, new QueryWrapper<>(multiQuestion));
                    } else {
                        result = multiQuestionMapper.selectPage(page, null);
                    }
                    break;
                case "填空题":
                    if (StringUtils.isNotBlank(subject)) {
                        FillQuestion fillQuestion = new FillQuestion();
                        fillQuestion.setSubject(subject);
                        result = fillQuestionMapper.selectPage(page, new QueryWrapper<>(fillQuestion));
                    } else {
                        result = fillQuestionMapper.selectPage(page, null);
                    }
                    break;
                case "判断题":
                    if (StringUtils.isNotBlank(subject)) {
                        JudgeQuestion judgeQuestion = new JudgeQuestion();
                        judgeQuestion.setSubject(subject);
                        result = judgeQuestionMapper.selectPage(page, new QueryWrapper<>(judgeQuestion));
                    } else {
                        result = judgeQuestionMapper.selectPage(page, null);
                    }
                    break;
            }
            List<Map> resultList = Lists.newArrayList();
            for (Object record : result.getRecords()) {
                Map map = JSONObject.parseObject(JSONObject.toJSONString(record), Map.class);
                map.put("type", questionType);
                resultList.add(map);
            }
            result.setRecords(resultList);
        } else {
            if (StringUtils.isNotBlank(subject)) {
                result = answerMapper.findAllBySubject(page, subject);
            } else {
                result = answerMapper.findAll(page);
            }
            List<Map> resultList = Lists.newArrayList();
            for (Object record : result.getRecords()) {
                Map map = JSONObject.parseObject(JSONObject.toJSONString(record), Map.class);
                resultList.add(map);
            }
            result.setRecords(resultList);
        }

        if(StringUtils.isNotBlank(paperId)) {
            isAdd(result.getRecords(), paperId);
        }

        return result;
    }

    private void isAdd(List records, String paperId) {
        List<PaperManage> allPaperQuestion = getAllPaperQuestion(paperId);
        for (Object record : records) {
            String questionId = ((Map) record).get("questionId").toString();
            String type = ((Map) record).get("type").toString();
            for (PaperManage paperManage : allPaperQuestion) {
                String questionType = "";
                switch (paperManage.getQuestionType()) {
                    case 1:
                        questionType = "选择题";
                        break;
                    case 2:
                        questionType = "填空题";
                        break;
                    case 3:
                        questionType = "判断题";
                        break;
                }
                if (StringUtils.equals(questionId, paperManage.getQuestionId().toString())
                        && StringUtils.equals(type, questionType)) {
                    ((Map) record).put("isInclude", true);
                    break;
                } else {
                    ((Map) record).put("isInclude", false);
                }
            }
        }
    }

    private List<PaperManage> getAllPaperQuestion(String paperId) {
        PaperManage paperManage = new PaperManage();
        paperManage.setPaperId(Integer.valueOf(paperId));
        return paperMapper.selectList(new QueryWrapper<>(paperManage));
    }

}
