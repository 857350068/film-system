package com.filmsystem.mapreduce.gender;

import java.io.IOException;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

/**
 * 性别维度评分分析Reducer
 * 输入：(gender:movieId:movieTitle, [rating1, rating2, ...])
 * 输出：(avgRating, gender:movieId:movieTitle)
 * 
 * @author FilmSystem
 */
public class GenderRatingReducer extends Reducer<Text, DoubleWritable, DoubleWritable, Text> {
    
    private DoubleWritable result = new DoubleWritable();
    
    @Override
    public void reduce(Text key, Iterable<DoubleWritable> values, Context context)
            throws IOException, InterruptedException {
        
        double sum = 0.0;
        int count = 0;
        
        for (DoubleWritable value : values) {
            sum += value.get();
            count++;
        }
        
        // 计算平均评分
        double avgRating = sum / count;
        
        // 输出：(avgRating, gender:movieId:movieTitle)
        result.set(avgRating);
        context.write(result, key);
    }
}