package com.filmsystem.mapreduce.rating;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

/**
 * 评价次数统计Reducer
 * 输入：(movieId:movieTitle, [1, 1, 1, ...])
 * 输出：(评价次数, movieId:movieTitle)
 * 
 * @author FilmSystem
 */
public class RatingCountReducer extends Reducer<Text, IntWritable, IntWritable, Text> {
    
    private IntWritable result = new IntWritable();
    
    @Override
    public void reduce(Text key, Iterable<IntWritable> values, Context context)
            throws IOException, InterruptedException {
        
        int sum = 0;
        for (IntWritable value : values) {
            sum += value.get();
        }
        
        // 输出：(评价次数, movieId:movieTitle)
        result.set(sum);
        context.write(result, key);
    }
}