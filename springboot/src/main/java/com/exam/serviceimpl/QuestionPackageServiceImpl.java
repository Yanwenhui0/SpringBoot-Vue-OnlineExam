package com.exam.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.entity.FillQuestion;
import com.exam.entity.JudgeQuestion;
import com.exam.entity.MultiQuestion;
import com.exam.entity.QuestionPackage;
import com.exam.mapper.JudgeQuestionMapper;
import com.exam.mapper.QuestionPackageMapper;
import com.exam.service.FillQuestionService;
import com.exam.service.JudgeQuestionService;
import com.exam.service.MultiQuestionService;
import com.exam.service.QuestionPackageService;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author yanwenhui
 * @date 2020/4/5 22:34
 */
@Service
public class QuestionPackageServiceImpl implements QuestionPackageService {

    @Autowired
    QuestionPackageMapper questionPackageMapper;

    @Autowired
    MultiQuestionService multiQuestionService;

    @Autowired
    JudgeQuestionService judgeQuestionService;

    @Autowired
    FillQuestionService fillQuestionService;

    @Override
    public void save(QuestionPackage questionPackage) {
        QueryWrapper<QuestionPackage> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("studentId", questionPackage.getStudentId());
        queryWrapper.eq("questionId", questionPackage.getQuestionId());
        queryWrapper.eq("questionType", questionPackage.getQuestionType());
        QuestionPackage questionPackageDb = questionPackageMapper.selectOne(queryWrapper);
        if(null == questionPackageDb) {
            questionPackageMapper.insert(questionPackage);
        }
    }

    @Override
    public void delete(QuestionPackage questionPackage) {
        questionPackageMapper.deleteById(questionPackage.getPackageId());
    }

    @Override
    public IPage<QuestionPackage> getPackage(String studentId, int page, int size) {
        QueryWrapper<QuestionPackage> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("studentId", studentId);

        Page<QuestionPackage> myPage = new Page<>(page, size);
        IPage<QuestionPackage> questionPackageIPage = questionPackageMapper.selectPage(myPage, queryWrapper);
        questionPackageIPage.getRecords().forEach( question -> {
            switch (question.getQuestionType()) {
                case "选择题":
                    MultiQuestion byId = multiQuestionService.findById(question.getQuestionId());
                    List<String> chooses = Lists.newArrayList();
                    chooses.add("A." + byId.getAnswerA());
                    chooses.add("B." + byId.getAnswerB());
                    chooses.add("C." + byId.getAnswerC());
                    chooses.add("D." + byId.getAnswerD());
                    question.setQuestionBody(byId.getQuestion());
                    question.setQuestionChoose(chooses);
                    question.setQuestionAnswer(byId.getRightAnswer());
                    break;
                case "填空题":
                    FillQuestion byId1 = fillQuestionService.findById(question.getQuestionId());
                    question.setQuestionBody(byId1.getQuestion());
                    question.setQuestionAnswer(byId1.getAnswer());
                    break;
                case "判断题":
                    JudgeQuestion byId2 = judgeQuestionService.findById(question.getQuestionId());
                    question.setQuestionBody(byId2.getQuestion());
                    question.setQuestionAnswer(byId2.getAnswer());
                    break;
            }
        });
        return questionPackageIPage;
    }
}
