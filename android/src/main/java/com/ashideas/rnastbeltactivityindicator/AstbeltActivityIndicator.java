package com.ashideas.rnastbeltactivityindicator;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.support.annotation.Nullable;
import android.util.AttributeSet;
import android.view.View;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Created by tigransahakyan on 8/11/17.
 */

public class AstbeltActivityIndicator extends View {

    //This is the percentage of tail's delay (in the whole animation). Progress is faster than it's delay.
    private static final float SPEED = 0.025f;
    private static final int PARTICLES_COUNT = 100;
    private static final float MIN_REL_SIZE = 0.02f;
    private static final float MAX_REL_SIZE = 0.05f;
    private static final float CIRCLE_WIDTH_PERCENT = 0.5f;

    private List<Particle> particles;
    private Paint blankPaint;
    private Paint progressPaint;
    private float progress;

    public AstbeltActivityIndicator(Context context) {
        super(context);
        init();
    }

    public AstbeltActivityIndicator(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public AstbeltActivityIndicator(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    private void init() {
        blankPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        blankPaint.setColor(Color.WHITE);
        blankPaint.setStyle(Paint.Style.FILL);

        progressPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        progressPaint.setColor(0xffdd55aa);
        progressPaint.setStyle(Paint.Style.FILL);

        particles = new ArrayList<>();

        Random random = new Random();
        for (int i = 0; i < PARTICLES_COUNT; i++) {
            Particle particle = new Particle();
            particle.rotation = random.nextFloat() * (float) Math.PI * 2;
            particle.distance = random.nextFloat() * (CIRCLE_WIDTH_PERCENT - MAX_REL_SIZE) + (1 - CIRCLE_WIDTH_PERCENT);
            particle.radius = random.nextFloat() * (MAX_REL_SIZE - MIN_REL_SIZE) + MIN_REL_SIZE;

            particles.add(particle);
        }
    }

    public void setBlankColor(String color) {
        if (color != null) {
            blankPaint.setColor(Color.parseColor(color));
        }
    }

    public void setProgressColor(String color) {
        if (color != null) {
            progressPaint.setColor(Color.parseColor(color));
        }
    }

    /**
     * Set a negative value for indeterminate.
     *
     * @param progress
     */
    public void setProgress(float progress) {
        this.progress = progress;
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        redraw(canvas);
    }

    private void redraw(Canvas canvas) {

        float center = canvas.getWidth() / 2f;
        double currentProgressRadian = (Math.PI * 2) * progress;

        for (Particle particle : particles) {
            float distFromCenter = center * particle.distance;

            particle.rotation += SPEED / (float) Math.sqrt(particle.distance - CIRCLE_WIDTH_PERCENT + 0.2);
            particle.rotation %= Math.PI * 2;

            double fixedRotation = (float) (particle.rotation - Math.PI / 2);

            canvas.drawCircle(center + (float) Math.cos(fixedRotation) * distFromCenter,
                    center + (float) Math.sin(fixedRotation) * distFromCenter,
                    particle.radius * center,
                    particle.rotation < currentProgressRadian ? progressPaint : blankPaint);
        }

        postInvalidateOnAnimation();
    }

    private class Particle {
        private float radius;
        private float rotation;
        private float distance;
    }
}