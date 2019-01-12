package com.ashideas.rnastbeltactivityindicator;

import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

public class AstbeltActivityIndicatorViewManager extends SimpleViewManager<AstbeltActivityIndicator> {

    private static final String REACT_CLASS = "AstbeltActivityIndicator";

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @ReactProp(name = "blankColor")
    public void setBlankColor(AstbeltActivityIndicator view, String color) {
        view.setBlankColor(color);
    }

    @ReactProp(name = "progressColor")
    public void setProgressColor(AstbeltActivityIndicator view, String color) {
        view.setProgressColor(color);
    }

    @ReactProp(name = "progress")
    public void setProgress(AstbeltActivityIndicator view, float progress) {
        view.setProgress(progress);
    }

    @Override
    protected AstbeltActivityIndicator createViewInstance(ThemedReactContext reactContext) {
        return new AstbeltActivityIndicator(reactContext);
    }
}
