import XCTest
@testable import SwiftyPodsDSL

final class SwiftyPodsDSLTests: XCTestCase {
    func testDependencyPropertyGeneratesExpectedString() {
        let property = DependencyProperty.git(url: "repoHere")
        XCTAssertEqual(property.render(), ":git => 'repoHere'")
    }
    
    func testDependencyWithVersionGeneratesExpectedString() {
        let dependency = Dependency(name: "aName", version: "1.2.3")
        XCTAssertEqual(dependency.render(tabs: 0).content, "pod 'aName', '1.2.3'")
    }
    
    func testDependencyWithVersionAndDependenciesGeneratesExpectedString() {
        let property = DependencyProperty.git(url: "repoHere")
        let dependency = Dependency(name: "aName", version: "1.2.3", properties: [property,property])
        XCTAssertEqual(dependency.render(tabs: 0).content, "pod 'aName', '1.2.3', :git => 'repoHere', :git => 'repoHere'")
    }
    
    func testDependencyWithTestSpecsGeneratesExpectedString() {
        let property = DependencyProperty.testsspecs(["testA", "testB"])
        let dependency = Dependency(name: "aName", properties: [property])
        XCTAssertEqual(dependency.render(tabs: 0).content, "pod 'aName', :testspecs => ['testA', 'testB']")
    }
    
    func testTargetGeneratesExpectedString() {
        let target = Target(name: "targetName", project: "projectFile.xproj")
        let expected = """
target 'targetName' do
    project 'projectFile.xproj'
end
"""
        XCTAssertEqual(target.render(tabs: 0).render(), expected)
    }
    
    func testTargetWithTabsGeneratesExpectedString() {
            let target = Target(name: "targetName", project: "projectFile.xproj")
            let expected = """
        target 'targetName' do
            project 'projectFile.xproj'
        end
    """
            XCTAssertEqual(target.render(tabs: 1).render(), expected)
        }
    
    func testTargetWithDependencyGeneratesExpectedString() {
        let dependency = Dependency(name: "aName", version: "1.2.3", properties: [])
        let target = Target(name: "targetName", project: "projectFile.xproj", dependencies: [dependency], childTargets: [])
        let expected = """
    target 'targetName' do
        project 'projectFile.xproj'
        pod 'aName', '1.2.3'
    end
    """
        XCTAssertEqual(target.render(tabs: 0).render(), expected)
    }
    
    func testTargetWithDependencyArrayGeneratesExpectedString() {
        let dependency = Dependency(name: "aName", version: "1.2.3", properties: [])
        let target = Target(name: "targetName", project: "projectFile.xproj", dependencies: [[dependency]], childTargets: [])
        let expected = """
    target 'targetName' do
        project 'projectFile.xproj'
        pod 'aName', '1.2.3'
    end
    """
        XCTAssertEqual(target.render(tabs: 0).render(), expected)
    }
    
    func testTargetWithChildGeneratesExpectedString() {
        let child = ChildTarget(name: "childTarget", project: "childProject.xproj", inheritSearchPaths: false, dependencies: [], childTargets: [])
        let target = Target(name: "targetName", project: "projectFile.xproj", childTargets: [child])
        let expected = """
    target 'targetName' do
        project 'projectFile.xproj'
        target 'childTarget' do
            project 'childProject.xproj'
        end
    end
    """
        XCTAssertEqual(target.render(tabs: 0).render(), expected)
    }
    
    func testChildTargetGeneratesExpectedString() {
        let child = ChildTarget(name: "childTarget", project: "childProject.xproj", inheritSearchPaths: false, dependencies: [], childTargets: [])
        let expected = """
    target 'childTarget' do
        project 'childProject.xproj'
    end
    """
        XCTAssertEqual(child.render(tabs: 0).render(), expected)
    }
    
    func testChildTargetWithPathsGeneratesExpectedString() {
        let child = ChildTarget(name: "childTarget", project: "childProject.xproj", inheritSearchPaths: true, dependencies: [], childTargets: [])
        let expected = """
    target 'childTarget' do
        project 'childProject.xproj'
        inherit! :search_paths
    end
    """
        XCTAssertEqual(child.render(tabs: 0).render(), expected)
    }
    
    func testPodfileGeneratesExpectedString() {
        let target = Target(name: "targetName", project: "projectFile.xproj")
        let podfile = Podfile(targets: [target])
        let expected = """
        target 'targetName' do
            project 'projectFile.xproj'
        end
        """
        XCTAssertEqual(podfile.render(), expected)
    }

    static var allTests = [
        ("testDependencyPropertyGeneratesExpectedString", testDependencyPropertyGeneratesExpectedString),
    ]
}
